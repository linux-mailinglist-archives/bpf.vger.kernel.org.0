Return-Path: <bpf+bounces-3735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776AC742797
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87841C20B60
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB711CBE;
	Thu, 29 Jun 2023 13:40:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B41096A
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:40:57 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4230F7
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:40:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e09a5b19so582510f8f.0
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688046054; x=1690638054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGXK3C74QJuocmmCvr9+ftQeIaLnPFI8vnaWY2A8whc=;
        b=i9SfxqWHjUp/WXLt1WJ2bmxBsACWRUAk0rc+V4t4bXJqrRLDp5ae8ea4vJjVjUtaCc
         mRsTi6+2uDtnKCnGs2Dl+jKyV4CiBkGpBDRR7mBIo4HbDbLrs71NrdEFYnkewf17R6BM
         E+vGOhOdG7VGFvSXeCAx/+pP/5x17yrsCSkjLHFJnVR3xBo+8teD+D1UBRg2ujWeEkde
         BWA9Ygce/DcyLo9lom39b60W2aIgOYdp+ErSnuxp0QB92mtVgyCJ4oPpvnfi69xw+4aC
         XOEK0QuZtgIgOEreL822AsNcoUWiYBOaKqve1WcHPVJW3v1PIWWFUv5YcLAe4BOPqLgY
         lxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688046054; x=1690638054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGXK3C74QJuocmmCvr9+ftQeIaLnPFI8vnaWY2A8whc=;
        b=cdO7i+nQU1KYrkp0R6QxaMwxVEcebU1/TiE+HL+2go74x08PomDYTmOkopAh8xo7nE
         9hKeiC525GLSuBQakXvS/ASOtYhhYQ2wcSYMag41YiJLhDFByck3FI0bcK4ZhPVMUATv
         OXCuLQZS4B8asaqdCfGJnsae0Tpccy+K3e1gO6R3GT0ZJAtYqqkXhpg3MLn1qTjt3dSw
         p/YAA8aqIEUS5p80OpCbXGDBSZGC7fXrymT5vERhOHVV10RLCysJvdyorI2V45oIsAOo
         hkC9sCN5g2sszbqW8IhTIdrDn406SIAWUvd4lwWN5kbrd63u8Sa/PJ9bPzkyiucNmpzF
         QoVA==
X-Gm-Message-State: ABy/qLZPe7OdhFKEBMKhh2EGjVVEFoq17O5DOKZEkqUNC/qwcXTe2tPA
	tAKNpofz257fMUMfOW2f6s6YXg==
X-Google-Smtp-Source: APBJJlGotcoLWANjsEy3iSZbDwVbvoXo/ZN4D3rSkJn1WhYaYLlTFvVKgS8hGYILgrkTNRiMSERfgA==
X-Received: by 2002:a5d:440f:0:b0:314:11da:7c73 with SMTP id z15-20020a5d440f000000b0031411da7c73mr3210307wrq.11.1688046053981;
        Thu, 29 Jun 2023 06:40:53 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:48c4:4b87:cc05:b4fb? ([2a02:8011:e80c:0:48c4:4b87:cc05:b4fb])
        by smtp.gmail.com with ESMTPSA id k9-20020adff5c9000000b0031411b7087dsm2902402wrp.20.2023.06.29.06.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 06:40:53 -0700 (PDT)
Message-ID: <ebb24b2d-e7f4-a726-a03d-a89dc483efac@isovalent.com>
Date: Thu, 29 Jun 2023 14:40:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 bpf-next 11/11] bpftool: Show perf link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-12-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230628115329.248450-12-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-28 11:53 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Enhance bpftool to display comprehensive information about exposed
> perf_event links, covering uprobe, kprobe, tracepoint, and generic perf=

> event. The resulting output will include the following details:
>=20
> $ tools/bpf/bpftool/bpftool link show
> 3: perf_event  prog 14
>         event software:cpu-clock
>         bpf_cookie 0
>         pids perf_event(19483)
> 4: perf_event  prog 14
>         event hw-cache:LLC-load-misses
>         bpf_cookie 0
>         pids perf_event(19483)
> 5: perf_event  prog 14
>         event hardware:cpu-cycles
>         bpf_cookie 0
>         pids perf_event(19483)
> 6: perf_event  prog 19
>         tracepoint sched_switch
>         bpf_cookie 0
>         pids tracepoint(20947)
> 7: perf_event  prog 26
>         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
>         bpf_cookie 0
>         pids uprobe(21973)
> 8: perf_event  prog 27
>         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
>         bpf_cookie 0
>         pids uprobe(21973)
> 10: perf_event  prog 43
>         kprobe ffffffffb70a9660 kernel_clone
>         bpf_cookie 0
>         pids kprobe(35275)
> 11: perf_event  prog 41
>         kretprobe ffffffffb70a9660 kernel_clone
>         bpf_cookie 0
>         pids kprobe(35275)
>=20
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":3,"type":"perf_event","prog_id":14,"event_type":"software","even=
t_config":"cpu-clock","bpf_cookie":0,"pids":[{"pid":19483,"comm":"perf_ev=
ent"}]},{"id":4,"type":"perf_event","prog_id":14,"event_type":"hw-cache",=
"event_config":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":19483,"com=
m":"perf_event"}]},{"id":5,"type":"perf_event","prog_id":14,"event_type":=
"hardware","event_config":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":1948=
3,"comm":"perf_event"}]},{"id":6,"type":"perf_event","prog_id":19,"tracep=
oint":"sched_switch","bpf_cookie":0,"pids":[{"pid":20947,"comm":"tracepoi=
nt"}]},{"id":7,"type":"perf_event","prog_id":26,"retprobe":false,"file":"=
/home/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pids":[{"=
pid":21973,"comm":"uprobe"}]},{"id":8,"type":"perf_event","prog_id":27,"r=
etprobe":true,"file":"/home/dev/waken/bpf/uprobe/a.out","offset":4920,"bp=
f_cookie":0,"pids":[{"pid":21973,"comm":"uprobe"}]},{"id":10,"type":"perf=
_event","prog_id":43,"retprobe":false,"addr":18446744072485508704,"func":=
"kernel_clone","offset":0,"bpf_cookie":0,"pids":[{"pid":35275,"comm":"kpr=
obe"}]},{"id":11,"type":"perf_event","prog_id":41,"retprobe":true,"addr":=
18446744072485508704,"func":"kernel_clone","offset":0,"bpf_cookie":0,"pid=
s":[{"pid":35275,"comm":"kprobe"}]}]
>=20
> For generic perf events, the displayed information in bpftool is limite=
d to
> the type and configuration, while other attributes such as sample_perio=
d,
> sample_freq, etc., are not included.
>=20
> The kernel function address won't be exposed if it is not permitted by
> kptr_restrict. The result as follows when kptr_restrict is 2.
>=20
> $ tools/bpf/bpftool/bpftool link show
> 3: perf_event  prog 14
>         event software:cpu-clock
> 4: perf_event  prog 14
>         event hw-cache:LLC-load-misses
> 5: perf_event  prog 14
>         event hardware:cpu-cycles
> 6: perf_event  prog 19
>         tracepoint sched_switch
> 7: perf_event  prog 26
>         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> 8: perf_event  prog 27
>         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> 10: perf_event  prog 43
>         kprobe kernel_clone
> 11: perf_event  prog 41
>         kretprobe kernel_clone
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!

