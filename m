Return-Path: <bpf+bounces-9484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056E79868D
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131D11C20C1F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17A5221;
	Fri,  8 Sep 2023 11:44:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A14C77
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 11:44:05 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260541BE7
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 04:44:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so2641763a12.3
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 04:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694173442; x=1694778242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LmdzpkbNmFIdc9Fv5w129fpnoRSOXFF9Td0X+ZjApCk=;
        b=gzhMmSdnvX6H4pe7lfzw2Ps/MJnRkP52EbDnfCQrT1O4SsC+D6d5ucfUd5Ef0PykeO
         gJUgWwHtaebTcqFQ76ySDdRGvnY7UEx9zMiddtsswQZpzQ0RNHVAFhVJDkd3e2V7Y6Rg
         7PTB0XWirZA4Kbv8HEn49RKKn4zvaqQt4/hFI7Om2wilhEmFit2gVRVj8EA9WgsSBOxW
         VA2LXnQdJZGdjPL7mDzwIFnM/sgxT3tNBa6nW8xoZ6MN1GqT0RpIij7MH/74zimuuXAP
         zXrcxjxj39SXE29F7NjUHSMRnKBEbD6PExJbzhPI+gnllnzoZwt9mf/U1lN5cNpLkp2l
         Z7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694173442; x=1694778242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmdzpkbNmFIdc9Fv5w129fpnoRSOXFF9Td0X+ZjApCk=;
        b=XLLEpQdPjluv+2PJDxUqk7DSijabTPpmawAJEsfObU47Sw0k674a3xCWOxeKFUq7pM
         bPVDGcos3Me2pDsRIDLoCZ/ZADNBbgFe21IZbmDix6Qg6j7v9p4mg/5/ZockdQj5GRv7
         /UZJvtd8jQAfnCruimcD2LvexEjPAwkGPDVVPoU6HjT/8bJ4gzQG+0AAKPN0uTiIBht2
         ofm/YCBpiL9PvnXTozQTZ23zw57/uO+PcS4LCupwD6K3knh7q0YcxCxd8jIX+IP8smLi
         5HLVNrNUf3tLv8GnWc3Ns1UpzVcabPjv1OpbdeR1XXVc6myIGGZVsOj4DTovtMk20V+H
         nD0g==
X-Gm-Message-State: AOJu0YzKfGKTmScgrNvDyFI1TNILyPIr46Uw8utWl85GHAo9egTxXvPZ
	w02VYMmdJipbgnY3PAOZh84=
X-Google-Smtp-Source: AGHT+IGtWuE5rb8yh+CWcR1m+aXymPQMaDcjHKIROJ6UBSQhQBxiYYODxrsRUFxD4vq3ctvYa7Hdsg==
X-Received: by 2002:a17:906:9e:b0:9a5:cf6f:3efc with SMTP id 30-20020a170906009e00b009a5cf6f3efcmr1692306ejc.77.1694173442298;
        Fri, 08 Sep 2023 04:44:02 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ck19-20020a170906c45300b009a1a653770bsm920533ejb.87.2023.09.08.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 04:44:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 8 Sep 2023 13:43:59 +0200
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link
 info
Message-ID: <ZPsI/4nX7IUpJ6Gr@krava>
References: <20230907071311.254313-1-jolsa@kernel.org>
 <20230907071311.254313-4-jolsa@kernel.org>
 <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 11:40:46AM -0700, Song Liu wrote:
> On Thu, Sep 7, 2023 at 12:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add missed value to kprobe attached through perf link info to
> > hold the stats of missed kprobe handler execution.
> >
> > The kprobe's missed counter gets incremented when kprobe handler
> > is not executed due to another kprobe running on the same cpu.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]
> 
> The code looks good to me. But I have two thoughts on this (and 2/9).
> 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index e5216420ec73..e824b0c50425 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6546,6 +6546,7 @@ struct bpf_link_info {
> >                                         __u32 name_len;
> >                                         __u32 offset; /* offset from func_name */
> >                                         __u64 addr;
> > +                                       __u64 missed;
> >                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
> >                                 struct {
> >                                         __aligned_u64 tp_name;   /* in/out */
> 
> 1) Shall we add missed for all bpf_link_info? Something like:
> 
> diff --git i/include/uapi/linux/bpf.h w/include/uapi/linux/bpf.h
> index 5a39c7a13499..cf0b8b2a8b39 100644
> --- i/include/uapi/linux/bpf.h
> +++ w/include/uapi/linux/bpf.h
> @@ -6465,6 +6465,7 @@ struct bpf_link_info {
>         __u32 type;
>         __u32 id;
>         __u32 prog_id;
> +       __u64 missed;
>         union {
>                 struct {
>                         __aligned_u64 tp_name; /* in/out: tp_name buffer ptr */

hm, there's lot of links under bpf_link_info, can't really tell if
all could gather 'missed' data.. like I don't think we have any for
standard perf event or perf tracepoint

> 
> 2) "missed" doesn't seem to fit well with other information in
> struct bpf_link_info. Other information there are more like stable-ish
> information; while missed is a stat that changes over time. Given we
> have prog_id in bpf_link_info, do we really need "missed" here?

right, OTOH there's recursion_misses/run_time_ns/run_cnt in bpf_prog_info

the bpf link has access to its attach layer, like perf event for kprobe
in perf_link or fprobe for kprobe_multi link... so it's convenient to
reach out from link for these stats and make them available through
bpf_link_info

also there's no other way to get these data for some links

like we could perhaps add some perf event specific interface to retrieve
these stats for kprobes, because we have access to the perf event in user
space, but that's not the case for kprobe_multi link, because there's no
other way to reach the fprobe object

jirka

