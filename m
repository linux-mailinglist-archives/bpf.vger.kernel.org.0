Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65359589A40
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiHDKBy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiHDKBy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 06:01:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B76435
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 03:01:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l19so3287881wms.1
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8mkCbeHZR9zmPPJnMG/D5q2gPsSK0TPYA17bB7Gcse8=;
        b=DuM4IGJu9Qt8XFXjjQLmVdyw68y2mFp1si+LAbL0hbMiAiRySJ+duKw7iy61B6wAhx
         uAOz25dki/XN78MwjYrI/5H5ylhIoKrR5xFXr2NVkIzcEX+kuyH9lcTTTnEaQKoMuTog
         8XLHr+dz5/Zs4z8H8StTmjOQoMSLvFnZVDcESOiju46fZCxSULaMKTiPp7+agztcw+vW
         8ZOu++PcsxZ3h1kvd/vplqgFwJc5Jp0x/Algp0Cik/wljY9/S6puKSBBOgyPpe8YmbKa
         2SjWTA5UN9exHy6h0qTvXSF9RnDuFpC/n7GInspSaYhmWCC5+43xmfouMWHmZufg75Mu
         31Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8mkCbeHZR9zmPPJnMG/D5q2gPsSK0TPYA17bB7Gcse8=;
        b=cOyLjLDiFz3gUFqjixaN/qxDUTHn9MI5kqXSrhx5dxNGT4WEV9TaGyztRIY2VCvbpz
         1aR9wNrwDmd54biEZnZ6kdFp603bE0M5C5ge+Jp/19HZvHfivP5YHhHi55lyg11vAdfA
         rmmxptXLH6eMKC7/ePi/8I1K2r0mOY4gRMsM3l5a1g20xwQJbNFSpzJqAamMD1SkLa/U
         eytaruEqczmPLJn4Ndrn7Uqkhn238sSBkdsZpYOcOjTjRIcDiCrFGxJ3B/p8+L1Erwka
         HLrAcLGNkHvnR5nXkby9KoLlK2RpbpymbRlWpJ35UBO28qCVsC5nWL8KOMt1fWnZV0ir
         /bxw==
X-Gm-Message-State: ACgBeo1KVHqBgIoj5enZ83yRcSOeU6C06ZyTiiTVj3bSdx3XEAvoF8n5
        LYn4AR2EIcI6fxCFAfYQIdJ5lg==
X-Google-Smtp-Source: AA6agR5JTkrIRbtYdXNW/Pv+OF2pQxRgGGqIqwN/c3wgfCKGZ0SE/60Ykc2WNcZ0XxkLzDSLgz0SNA==
X-Received: by 2002:a05:600c:3d17:b0:3a3:2bc8:6132 with SMTP id bh23-20020a05600c3d1700b003a32bc86132mr888630wmb.24.1659607309693;
        Thu, 04 Aug 2022 03:01:49 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003a342933727sm5835197wmb.3.2022.08.04.03.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 03:01:49 -0700 (PDT)
Message-ID: <91477d69-5fe6-5815-3bba-f63764bd61e3@isovalent.com>
Date:   Thu, 4 Aug 2022 11:01:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: How about adding a name for bpftool self created maps?
Content-Language: en-GB
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <YrEoRyty7decoMhh@Laptop-X1>
 <CACdoK4JrrVoMjvwQusdpYOO5gDqZDKky2QZqyb08p+2R1186Gw@mail.gmail.com>
 <YutngHf+k4BGjkxf@Laptop-X1>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <YutngHf+k4BGjkxf@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/08/2022 07:30, Hangbin Liu wrote:
> On Tue, Jun 21, 2022 at 10:28:27PM +0100, Quentin Monnet wrote:
>> Hi Hangbin,
>>
>> No plan currently. Adding names has been suggested before, but it's
>> not compatible with some older kernels that don't support map names
>> [0]. Maybe one solution would be to probe the kernel for map name
>> support, and to add a name if supported.
> 
> Hi Quentin,
> 
> I looked into this issue this week. And I have some questions.
> Can we just use the probe_kern_prog_name() function directly? e.g.
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..f7d1580cd54e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4476,7 +4476,10 @@ static int probe_kern_global_data(void)
>         };
>         int ret, map, insn_cnt = ARRAY_SIZE(insns);
> 
> -       map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
> +       if (probe_kern_prog_name() > 0)
> +               map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "global_data", sizeof(int), 32, 1, NULL);
> +       else
> +               map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
>         if (map < 0) {
>                 ret = -errno;
>                 cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> 
> I know the map name and prog name supports are not in the same patch. But they are
> added to kernel in one patch series. I doubt any one will backport them separately.

Hi! It would look much cleaner to have something specific to map names.
It does not have to be a dedicated probe in my opinion, maybe we can
just try loading with a name and retry if this fails with -EINVAL (a bit
like we retry with another prog type in bpf_object__probe_loading(), if
the first one fails). Something like this (not tested):

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 50d41815f431..abcafdf8ae7e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4430,7 +4430,10 @@ static int probe_kern_global_data(void)
 	};
 	int ret, map, insn_cnt = ARRAY_SIZE(insns);
 
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32,  1, NULL);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "global_data", sizeof(int), 32, 1, NULL);
+	if (map < 0 && errno == EINVAL)
+		/* Retry without name */
+		map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));

(Maybe with a small wrapper, given that we'd also need this in
probe_prog_bind_map() and probe_kern_array_mmap() as well.)

> And I also have a question about function probe_kern_prog_name(). I only
> saw it created a prog with name "test". But I didn't find the function check
> if the prog are really has name "test". If a old kernel doesn't support prog
> name, I think it will just ignore the name field. No?

No, "if (CHECK_ATTR(BPF_PROG_LOAD))" should fail in bpf_prog_load() in
kernel/bpf/syscall.c, and the syscall should fail with -EINVAL.

If older kernels simply ignored the "name" field for programs and maps,
we wouldn't have to probe or retry for the current case in the first
place :).

> Another way I think we can use to probe if kernel supports map name is try
> to attach a kprobe/bpf_obj_name_cpy. If attach success, the kernel should support
> the prog/map name. WDYT?

It's probably easier to try to load a map with a name. Also kprobes can be
disabled, if I remember correctly.

Thanks,
Quentin
