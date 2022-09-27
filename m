Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7955EC892
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiI0Pvv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiI0Pvc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 11:51:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AE543DE
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 08:49:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nb11so21603239ejc.5
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=eLALLLuXdZ6osFhpEvKHD+mFwNZ1pYBWmzjVEdrEzO4=;
        b=iQ++IGNKUoKz3AAkudafAL7uov8TpSUYPa/9snuh8x6l9RcEB35PLn90GyOzbAimVf
         OZNYqQsTP/Mdpm5KWNB8w/mXuKK47AKAwBFV1WQ95aPuCbuzKIQ+kEzaEjFEW3KcP3KK
         VoyDzmhOexEg+V7sm1qdSv+fTCC1wqSVgAZ5MsQIK6jco0X5xVH7qo/N4n4kpAnLnFux
         dhkK3/QSdX760QR/SLFbvB+ByFNAyc6hVDZCBGUq8y5zUMte60hih+KMHvAkFyQL+vl6
         SvKoSyyChb7Riohe89fu4of1MrRYuKN3vZ7UpkDl3E5bEPHmo3V2RXa6OfcB+V3Pj8ED
         D/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eLALLLuXdZ6osFhpEvKHD+mFwNZ1pYBWmzjVEdrEzO4=;
        b=rd6fGPUX5SpQgBtqsJpp0HmPvbrF5MIGH7m2H/+OfhBZmpWImf8HKqFPUyApYcPLrL
         so9orPVsvwYqjpghijP3fWU1zzWRR1UYyhlczTzsQDq1IDJtdTnk7TzOW8AnKYbrV8E3
         nNLe1ts7KOBw2kaB5QiCC5Plf7eI0LfuWtWWCkAkj3Bz9ixz+pRslsFa/5B7ifFgSNLc
         LldJycLK8GxMIikUOxSMSq4FQ3mfLtsS7aRs0RQ2PmVPpQ85cMfkoAaOe9hLRJuOwKKP
         4rVpLOHyU6vODf8NmkrJSXtBgAVwixHo2XOyM8/KoQZpmmCg1uMig/D3MJp59Y2ETCsn
         VYqA==
X-Gm-Message-State: ACrzQf0EIq0vg4aHW29ggEpE+LgYuV0MQKHm9sbiL2eZF+mVgeZd3wEL
        5RQvyI80c8V2qmwpgVTiMBYp/0WnVhQ=
X-Google-Smtp-Source: AMsMyM5k3ciCI6eLmQsCBw8KQm43C8je6rPMg0LSpVqyKATl8QsKzqfXb2Vfo1fGZaaY3Zo5oQeRmg==
X-Received: by 2002:a17:907:2d0b:b0:782:76dc:e557 with SMTP id gs11-20020a1709072d0b00b0078276dce557mr19840096ejc.690.1664293790813;
        Tue, 27 Sep 2022 08:49:50 -0700 (PDT)
Received: from krava ([83.240.61.46])
        by smtp.gmail.com with ESMTPSA id kx17-20020a170907775100b007262a5e2204sm978542ejc.153.2022.09.27.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:49:50 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 27 Sep 2022 17:49:48 +0200
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: Multi kprobe ftrace_lookup_symbols question
Message-ID: <YzMbnJLL1yYmT9L4@krava>
References: <CAK3+h2z-y0VdTteSF2Bna3dF-n4XKU5x6wZOzu8q+_BCUg3G6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3+h2z-y0VdTteSF2Bna3dF-n4XKU5x6wZOzu8q+_BCUg3G6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 07:58:23AM -0700, Vincent Li wrote:
> Hi,
> 
> I have sample code like below to give duplicate "vprintk" symbols to
> multi kprobe attachment, it results in ESRCH return from
> ftrace_lookup_symbols, I assume it should be user space code
> responsibility not to feed kernel with duplicate symbols, correct? the
> sort_r() in  bpf_kprobe_multi_link_attach() seems not to remove
> duplicate symbols.

hi,
correct, symbols must be unique, ftrace_lookup_symbols (kernel/trace/ftrace.c)
will fail if there are duplicate symbols on input

> 
> import (
> 
>         "fmt"
> 
> 
>         "github.com/cilium/ebpf"
> 
>         "github.com/cilium/ebpf/asm"
> 
>         "github.com/cilium/ebpf/link"
> 
> )
> 
> 
> func detectKprobeMulti() bool {
> 
>         prog, err := ebpf.NewProgram(&ebpf.ProgramSpec{
> 
>                 Name: "probe_bpf_kprobe_multi_link",
> 
>                 Type: ebpf.Kprobe,
> 
>                 Instructions: asm.Instructions{
> 
>                         asm.Mov.Imm(asm.R0, 0),
> 
>                         asm.Return(),
> 
>                 },
> 
>                 AttachType: ebpf.AttachTraceKprobeMulti,
> 
>                 License:    "MIT",
> 
>         })
> 
>         if err != nil {
> 
>                 return false
> 
>         }
> 
>         defer prog.Close()
> 
> 
>         syms := []string{"vprintk", "vprintk"}
> 
>         opts := link.KprobeMultiOptions{Symbols: syms}

you can resolve all 'vprintk' functions yourself and attach it through
KprobeMultiOptions::Addresses array

jirka

> 
> 
>         _, err = link.KprobeMulti(prog, opts)
> 
>         return err == nil
> 
> }
> 
> 
> func main() {
> 
>         if detectKprobeMulti() {
> 
>                 fmt.Println(" it works\n")
> 
>         }
> 
> }
