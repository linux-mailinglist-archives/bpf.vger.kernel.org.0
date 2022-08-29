Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7245A5589
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 22:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiH2U30 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 16:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2U3Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 16:29:24 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772285FCC;
        Mon, 29 Aug 2022 13:29:23 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSlNn-000G6Y-Df; Mon, 29 Aug 2022 22:29:19 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSlNm-000GuQ-V1; Mon, 29 Aug 2022 22:29:18 +0200
Subject: Re: [PATCH v2] Fit lines in 80 columns
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <20220829195842.85290-1-alx.manpages@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0760a7e9-c3a5-fc27-0553-dc4ec6df554b@iogearbox.net>
Date:   Mon, 29 Aug 2022 22:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220829195842.85290-1-alx.manpages@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/29/22 9:58 PM, Alejandro Colomar wrote:
> Those lines is used to generate the bpf-helpers(7) manual page.
> They are no-fill lines, since they represent code, which means
> that the formatter can't break the line, and instead just runs
> across the right margin (in most set-ups this means that the pager
> will break the line).
> 
> Using <fmt> makes it end exactly at the 80-col right margin, both
> in the header file, and also in the manual page, and also seems to
> be a sensible name to me.
> 
> In the other case, the fix has been to separate the variable
> definition and its use, as the kernel coding style recommends.
> 
> Nacked-by: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf <bpf@vger.kernel.org>
> Cc: linux-man <linux-man@vger.kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: "G. Branden Robinson" <g.branden.robinson@gmail.com>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
>   include/uapi/linux/bpf.h       | 11 ++++++-----
>   tools/include/uapi/linux/bpf.h | 11 ++++++-----
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ef78e0e1a754..1443fa2a1915 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1619,7 +1619,7 @@ union bpf_attr {
>    *
>    * 		::
>    *
> - * 			telnet-470   [001] .N.. 419421.045894: 0x00000001: <formatted msg>
> + * 			telnet-470   [001] .N.. 419421.045894: 0x00000001: <fmt>
>    *
>    * 		In the above:
>    *
> @@ -1636,8 +1636,7 @@ union bpf_attr {
>    * 			* ``419421.045894`` is a timestamp.
>    * 			* ``0x00000001`` is a fake value used by BPF for the
>    * 			  instruction pointer register.
> - * 			* ``<formatted msg>`` is the message formatted with
> - * 			  *fmt*.
> + * 			* ``<fmt>`` is the message formatted with *fmt*.
>    *
>    * 		The conversion specifiers supported by *fmt* are similar, but
>    * 		more limited than for printk(). They are **%d**, **%i**,
> @@ -3860,8 +3859,10 @@ union bpf_attr {
>    * 			void bpf_sys_open(struct pt_regs *ctx)
>    * 			{
>    * 			        char buf[PATHLEN]; // PATHLEN is defined to 256
> - * 			        int res = bpf_probe_read_user_str(buf, sizeof(buf),
> - * 				                                  ctx->di);
> + * 			        int res;
> + *
> + * 			        res = bpf_probe_read_user_str(buf, sizeof(buf),
> + * 				                              ctx->di);
>    *

Aside that this has been Nacked before, this looks really ugly. I'm not applying
this, sorry.

Thanks,
Daniel
