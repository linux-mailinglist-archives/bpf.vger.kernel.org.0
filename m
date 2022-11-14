Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8298A628771
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiKNRuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbiKNRuA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:50:00 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2354B7E0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:49:59 -0800 (PST)
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1oudab-000GBq-8S; Mon, 14 Nov 2022 18:49:45 +0100
Date:   Mon, 14 Nov 2022 18:49:44 +0100
From:   Daniel Bokmann <darkstar@linux.home>
To:     sdf@google.com
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next v2] bpf: Pass map file to .map_update_batch
 directly
Message-ID: <20221114174944.GA29631@linux.home>
References: <20221111080757.2224969-1-houtao@huaweicloud.com>
 <Y26JtknJKjnD+dsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26JtknJKjnD+dsu@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26720/Mon Nov 14 09:52:56 2022)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 11, 2022 at 09:43:18AM -0800, sdf@google.com wrote:
> On 11/11, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> 
> > Currently bpf_map_do_batch() first invokes fdget(batch.map_fd) to get
> > the target map file, then it invokes generic_map_update_batch() to do
> > batch update. generic_map_update_batch() will get the target map file
> > by using fdget(batch.map_fd) again and pass it to
> > bpf_map_update_value().
> 
> > The problem is map file returned by the second fdget() may be NULL or a
> > totally different file compared by map file in bpf_map_do_batch(). The
> > reason is that the first fdget() only guarantees the liveness of struct
> > file instead of file descriptor and the file description may be released
> > by concurrent close() through pick_file().
> 
> > It doesn't incur any problem as for now, because maps with batch update
> > support don't use map file in .map_fd_get_ptr() ops. But it is better to
> > fix the access of a potentially invalid map file.

Right, that's mainly for the perf RB map ...

> > using __bpf_map_get() again in generic_map_update_batch() can not fix
> > the problem, because batch.map_fd may be closed and reopened, and the
> > returned map file may be different with map file got in
> > bpf_map_do_batch(), so just passing the map file directly to
> > .map_update_batch() in bpf_map_do_batch().
> 
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>

> [..]
> 
> > +#define BPF_DO_BATCH_WITH_FILE(fn)			\
> > +	do {						\
> > +		if (!fn) {				\
> > +			err = -ENOTSUPP;		\
> > +			goto err_put;			\
> > +		}					\
> > +		err = fn(map, f.file, attr, uattr);	\
> > +	} while (0)
> > +
> 
> nit: probably not worth defining this for a single user? but not sure
> it matters..

Yeah, just the BPF_DO_BATCH could be used but extended via __VA_ARGS__.

Thanks,
Daniel
