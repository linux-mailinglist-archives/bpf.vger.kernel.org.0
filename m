Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D326C8A54
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCYCyK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYCyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:54:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4039E15170
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:54:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id pm10-20020a17090b3c4a00b0023ff02aced2so3681666pjb.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679712848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMDD1MJeFWH1fUS3NN+T164qPGehR/b6EvKhekU9vEY=;
        b=Gl0lmlPUiCNbqlGNCY1ZYI02tDgE5FqOnR2CML5/7nvUTxQETzKcrm+ty33Fzuej9+
         LO/YMWrRpLaa6lbnBFzm75mw9+x4L3hWQUGE5i8k8E43f07+svcboFJxLMqwcBg0zCrv
         DOPNV+c+oQN7Um6DcziYdNB/KxmzBPZBMU1Zs2EXcXAqPzmNlUa3HdYVBa/YVDwE5aHc
         3IjdPY5S8qKF4b2B5Ed+QMI3sGbtPZC07jDTahrMpRJnbOhWO9mcUgnCPNNv2UpCF158
         FKqlL3ME86Uk7LSW1wmGK41+7mGtpTt6q4py+WU/KjXg/nY5B3NlNmmFe3HriKzNDdZ+
         5IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMDD1MJeFWH1fUS3NN+T164qPGehR/b6EvKhekU9vEY=;
        b=GlGBIU2F1OcqfftyQZ1xTioCBu24QQ11720a4YBZOoo6ILAwyqSgg9nwGPgGp6nkbK
         13EwKjTG5njzUTjSdg9PnyfEq47sCzr9EpJyzVG7yKtJmsQIjMQ11uIkjO1ECRHwnIoi
         YrJlls9UA8oT2+9NmJysW3lMQaXaOhHO66hXz480tKwkhRifnKxiiyvWf4hinShyLrOb
         mqZ3A1SgYeyy5l8mNjAZQHFImYJhuzZHTjJbt3YR/l9w0mDj//F+ik1Oc0lbpGJvoexB
         vueh7a3rytjHslOJ5VhuLNzHY8sbdxpFlMidQBBGUs7DdInAmfF0wmvNR0xwYo/ohsTw
         yxiw==
X-Gm-Message-State: AAQBX9e0mms8vwdrJCOSCXbL+1lNYClcHoY5UudTJRtSaE3R4Gn9Iija
        UHlExLRAuAjc/FZxMKlgf7EeNgI=
X-Google-Smtp-Source: AKy350anF6QTD2Sm1E4rMvtf11sqGJQhyiBpcRMHb7Ok1e/DV2kPOLYHmCXvODHWhU9BffAceqOnCBM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:5201:0:b0:4fc:2058:fa29 with SMTP id
 g1-20020a635201000000b004fc2058fa29mr1244789pgb.1.1679712848363; Fri, 24 Mar
 2023 19:54:08 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:54:07 -0700
In-Reply-To: <20230324230209.161008-3-quentin@isovalent.com>
Mime-Version: 1.0
References: <20230324230209.161008-1-quentin@isovalent.com> <20230324230209.161008-3-quentin@isovalent.com>
Message-ID: <ZB5iT1ux8YIL/Jr8@google.com>
Subject: Re: [PATCH bpf-next 2/5] bpftool: Fix bug for long instructions in
 program CFG dumps
From:   Stanislav Fomichev <sdf@google.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/24, Quentin Monnet wrote:
> When dumping the control flow graphs for programs using the 16-byte long
> load instruction, we need to skip the second part of this instruction
> when looking for the next instruction to process. Otherwise, we end up
> printing "BUG_ld_00" from the kernel disassembler in the CFG.

> Fixes: efcef17a6d65 ("tools: bpftool: generate .dot graph from CFG  
> information")
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---
>   tools/bpf/bpftool/xlated_dumper.c | 7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/tools/bpf/bpftool/xlated_dumper.c  
> b/tools/bpf/bpftool/xlated_dumper.c
> index 6fe3134ae45d..3daa05d9bbb7 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -372,8 +372,15 @@ void dump_xlated_for_graph(struct dump_data *dd,  
> void *buf_start, void *buf_end,
>   	struct bpf_insn *insn_start = buf_start;
>   	struct bpf_insn *insn_end = buf_end;
>   	struct bpf_insn *cur = insn_start;
> +	bool double_insn = false;

>   	for (; cur <= insn_end; cur++) {
> +		if (double_insn) {
> +			double_insn = false;
> +			continue;
> +		}
> +		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
> +
>   		printf("% 4d: ", (int)(cur - insn_start + start_idx));
>   		print_bpf_insn(&cbs, cur, true);
>   		if (cur != insn_end)

Any reason not to do the following here instead?

	if (cur->code == (BPF_LD | BPF_IMM | BPF_DW))
		cur++;

> --
> 2.34.1

