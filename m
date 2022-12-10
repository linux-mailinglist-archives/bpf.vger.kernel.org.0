Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992A4648D7C
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 08:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLJHeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 02:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLJHeF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 02:34:05 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604F1E719;
        Fri,  9 Dec 2022 23:33:48 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NTfg71RS8zJpGC;
        Sat, 10 Dec 2022 15:30:11 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 10 Dec
 2022 15:33:44 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <haoluo@google.com>, <john.fastabend@gmail.com>,
        <jolsa@kernel.org>, <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <yanan@huawei.com>, <yhs@fb.com>, <zhangmingyi5@huawei.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Optimized return value in libbpf_strerror when errno is libbpf errno
Date:   Sat, 10 Dec 2022 15:33:41 +0800
Message-ID: <20221210073341.233271-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <a34fe87e-42a8-7bed-805e-218b9d4554c0@iogearbox.net>
References: <a34fe87e-42a8-7bed-805e-218b9d4554c0@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 10 Dec 2022 00:12:58 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 12/9/22 12:05 PM, Xin Liu wrote:
> > This is a small improvement in libbpf_strerror. When libbpf_strerror
> > is used to obtain the system error description, if the length of the
> > buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
> > ERANGE.
> > 
> > However, this processing is not performed when the error code
> > customized by libbpf is obtained. Make some minor improvements here,
> > return -ERANGE and set errno to ERANGE when buf is not enough for
> > custom description.
> 
> nit: $subject line got corrupted?
> 
> > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > ---
> > 
> > v2:
> > Check the return value of snprintf to determine whether the buffer is
> > too small.
> > 
> > v1:
> > https://lore.kernel.org/bpf/20221209084047.229525-1-liuxin350@huawei.com/T/#t
> > 
> >   tools/lib/bpf/libbpf_errno.c | 15 +++++++++++----
> >   1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
> > index 96f67a772a1b..6240c7cb7472 100644
> > --- a/tools/lib/bpf/libbpf_errno.c
> > +++ b/tools/lib/bpf/libbpf_errno.c
> > @@ -39,14 +39,13 @@ static const char *libbpf_strerror_table[NR_ERRNO] = {
> >   
> >   int libbpf_strerror(int err, char *buf, size_t size)
> >   {
> > +	int ret;
> 
> nit: newline after declaration
> 
> >   	if (!buf || !size)
> >   		return libbpf_err(-EINVAL);
> >   
> >   	err = err > 0 ? err : -err;
> >   
> >   	if (err < __LIBBPF_ERRNO__START) {
> > -		int ret;
> > -
> >   		ret = strerror_r(err, buf, size);
> >   		buf[size - 1] = '\0';
> >   		return libbpf_err_errno(ret);
> > @@ -56,12 +55,20 @@ int libbpf_strerror(int err, char *buf, size_t size)
> >   		const char *msg;
> >   
> >   		msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
> > -		snprintf(buf, size, "%s", msg);
> > +		ret = snprintf(buf, size, "%s", msg);
> >   		buf[size - 1] = '\0';
> > +		if (ret < 0)
> > +			return libbpf_err_errno(ret);
> 
> This would pass in ret == -1 and then eventually return 1 which
> is misleading, no?
> 
> We have buf and msg non-NULL and a positive size, afaik, the only
> case where you could get a negative error now is when you pass in
> a buf with size exceeding INT_MAX..
> 
> > +		if (ret >= size)
> > +			return libbpf_err(-ERANGE);
> >   		return 0;
> >   	}
> >   
> > -	snprintf(buf, size, "Unknown libbpf error %d", err);
> > +	ret = snprintf(buf, size, "Unknown libbpf error %d", err);
> >   	buf[size - 1] = '\0';
> > +	if (ret < 0)
> > +		return libbpf_err_errno(ret);
> > +	if (ret >= size)
> > +		return libbpf_err(-ERANGE);
> >   	return libbpf_err(-ENOENT);
> >   }
> > 

The logic of returning negative numbers is really unlikely here,
I'll add some comments and delete this logic, thanks to Daniel
for pointing out.
