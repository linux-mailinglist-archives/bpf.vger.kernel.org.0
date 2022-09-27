Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0C5EC70C
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiI0O64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0O6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 10:58:36 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52373AE
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 07:58:34 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id bi53so5052742vkb.12
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=u+X8FUC0QSkC0atcGB6Nl+ZnhErIVyExF9VMBM5MNcg=;
        b=TY3cUbGa4DCqCHK6VOT5sibzQJWE51TlPnJ0vTDNlVbHZPvY/XxnM0LR56vPvH7jQa
         VAmnVjgXhErA8qw2AQjcjrRJrkQTKZ+J+3pjIkU6kuPpOKCJnN0/aehdEEhKQuzxk4Qk
         kbYYFNbq4vRtsv5VMSB1/W2AxFxMUeaHdYLd3cDtLkHOWP9DwFa+NARSL56/NIRAAFai
         ZCNvvXUow4mjm5ZUOUjtNUx81Z92QUfoscbd0BwLseSXOC6JR1nectztH0D8qW+jQEVj
         oM7JW58OVoNCmR9Q5gJ6P19tcgmgKC9NIYBvVEydy+RKYbgrHd0WlgpmIO15p/vghivN
         FsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=u+X8FUC0QSkC0atcGB6Nl+ZnhErIVyExF9VMBM5MNcg=;
        b=wtKkkt4ekMyiARVxlaT/fIpc1u67it3QOjYTFkCAgV6S5nZ0nUTWxOSSSk4hqmf6k/
         mnYxQ5IqAsBqzoENPzF1IWWXSiKL9hWTMDnZtnyl+w7iPPqh2xeZXGB2SHoLGlpifjwr
         Hg6K8QFSjL8ME6Ie7NqoR/ra17C4pzuaKI4Oya5mxoHAd8YcXsUAsu/R4PkMzG7lFiEr
         Gh6R9pcMhtrn5ENCRt8DIeixrjZYS8O0O9pt/WpS346wljadutXA1cyl42s73K+9MZ0V
         V3UgeH7BrkyXqr6xNqHvA0zfXDoFcn+mfAeqscKPlvMIlU82JIACzTS0SvtbUCiTqyMD
         5giw==
X-Gm-Message-State: ACrzQf3RcJqxVRx2V+oG+NxRDeMu6mipBqeQWMFRSJYQXDhtCi3ZRPgv
        /thGPZ4pC8RLsyAkm+ycuhop0nud+xoENDYGZujnZswcnD4=
X-Google-Smtp-Source: AMsMyM6aNZkJEaeE8qpYjBc/Fw9vI9ziL5s8lH5a+cUtjpPi0PPVnnsKTijXDM5hjnvH6HkjtVgT6O88GS8vwI5swaM=
X-Received: by 2002:ac5:c297:0:b0:3a2:4e1d:584f with SMTP id
 h23-20020ac5c297000000b003a24e1d584fmr11680722vkk.23.1664290713752; Tue, 27
 Sep 2022 07:58:33 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 27 Sep 2022 07:58:23 -0700
Message-ID: <CAK3+h2z-y0VdTteSF2Bna3dF-n4XKU5x6wZOzu8q+_BCUg3G6A@mail.gmail.com>
Subject: Multi kprobe ftrace_lookup_symbols question
To:     bpf <bpf@vger.kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I have sample code like below to give duplicate "vprintk" symbols to
multi kprobe attachment, it results in ESRCH return from
ftrace_lookup_symbols, I assume it should be user space code
responsibility not to feed kernel with duplicate symbols, correct? the
sort_r() in  bpf_kprobe_multi_link_attach() seems not to remove
duplicate symbols.

import (

        "fmt"


        "github.com/cilium/ebpf"

        "github.com/cilium/ebpf/asm"

        "github.com/cilium/ebpf/link"

)


func detectKprobeMulti() bool {

        prog, err := ebpf.NewProgram(&ebpf.ProgramSpec{

                Name: "probe_bpf_kprobe_multi_link",

                Type: ebpf.Kprobe,

                Instructions: asm.Instructions{

                        asm.Mov.Imm(asm.R0, 0),

                        asm.Return(),

                },

                AttachType: ebpf.AttachTraceKprobeMulti,

                License:    "MIT",

        })

        if err != nil {

                return false

        }

        defer prog.Close()


        syms := []string{"vprintk", "vprintk"}

        opts := link.KprobeMultiOptions{Symbols: syms}


        _, err = link.KprobeMulti(prog, opts)

        return err == nil

}


func main() {

        if detectKprobeMulti() {

                fmt.Println(" it works\n")

        }

}
