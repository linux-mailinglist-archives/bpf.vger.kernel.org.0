Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F25F3A1D
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 01:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJCXzW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 19:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJCXzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 19:55:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090A237C0
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 16:55:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f9-20020a25b089000000b006be298e2a8dso440515ybj.20
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=4X8uGt5eOJ31sEBPAS0bNTEDIqwP6jz6xWtp0NzhFmc=;
        b=PCUGz6WCjEVbeKYEoToTyc6FsYgh9ny3aJLwGXFSJHcWLCRZhkbp/rULdkbAfA6VKa
         fe/jdcuenWn7q9Yk+zrpfkr9Mhk29HMeatp5R2hyhhrVyaJ5bGzGSdH5bf8mwBWEf+mS
         WJpofnHCjZzpquZvmPDJgUaFZlWoeC/2+ubPY+JI4bNktsPFabWWiTl0iPIahh+RhdKH
         DjubzMzsfR+onzGW2habVokIfd8+nnmh3M5RTebjb6gSJ12U9nUjBhyFeBteg420unFU
         PVRuexpWhfLD+58eCcVd5xEVm2KRsq1wR0IoP03Vg7ndfaCO5uDTsdxWfEuEbk+462NL
         xuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=4X8uGt5eOJ31sEBPAS0bNTEDIqwP6jz6xWtp0NzhFmc=;
        b=cSgdeBVTvDbpx3YCk0wVffGRzT1Vt6C2E2xSKdgqkx1ZJrlUk4N89ra2FzUUAD946p
         OpsgtR/wJdxF75A2y8pD2/azeIkjWekka70oqI0tFIky3motPEqXlVp/wqPfXBTnapQT
         hWTRlLkYLbJogGauHWqW1UyDkCJYyukbLH2nttw8MAuagsMvwuJMQK3IjaGwEEfDMkYA
         EDQIg547BMvCk0uSF6ZWyOyguoSU3bonz3d7uGpxaug4WlRxytni1JOZefQGbshbIyoN
         SXHHBvbjCz9ISxAl1KrusxhRG57AXFc75B10dvHW8KE2nr/fO/k1LTX7MRE7ycVfhxws
         //BA==
X-Gm-Message-State: ACrzQf0znOppX2IlacyOVrfsuWvWrYPn+xv6IwFq1oh3UKm7Rwsm1pcX
        Gt2LppLDg4pVQ5tqbCIO6hQpAjY=
X-Google-Smtp-Source: AMsMyM49Ig+irIHqvO5COcdwFPN5tLUiVNlzIKJ8qc1vHYKaHSokkE3Dd+ForX5z24P7RShyFJ5gJZs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:4942:0:b0:6bd:29b0:3ed8 with SMTP id
 w63-20020a254942000000b006bd29b03ed8mr13928054yba.79.1664841316237; Mon, 03
 Oct 2022 16:55:16 -0700 (PDT)
Date:   Mon, 3 Oct 2022 16:55:14 -0700
In-Reply-To: <166256538687.1434226.15760041133601409770.stgit@firesoul>
Mime-Version: 1.0
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
Message-ID: <Yzt2YhbCBe8fYHWQ@google.com>
Subject: Re: [PATCH RFCv2 bpf-next 00/18] XDP-hints: XDP gaining access to HW
 offload hints via BTF
From:   sdf@google.com
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        mtahhan@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/07, Jesper Dangaard Brouer wrote:
> This patchset expose the traditional hardware offload hints to XDP and
> rely on BTF to expose the layout to users.

> Main idea is that the kernel and NIC drivers simply defines the struct
> layouts they choose to use for XDP-hints. These XDP-hints structs gets
> naturally and automatically described via BTF and implicitly exported to
> users. NIC drivers populate and records their own BTF ID as the last
> member in XDP metadata area (making it easily accessible by AF_XDP
> userspace at a known negative offset from packet data start).

> Naming conventions for the structs (xdp_hints_*) is used such that
> userspace can find and decode the BTF layout and match against the
> provided BTF IDs. Thus, no new UAPI interfaces are needed for exporting
> what XDP-hints a driver supports.

> The patch "i40e: Add xdp_hints_union" introduce the idea of creating a
> union named "xdp_hints_union" in every driver, which contains all
> xdp_hints_* struct this driver can support. This makes it easier/quicker
> to find and parse the relevant BTF types.  (Seeking input before fixing
> up all drivers in patchset).


> The main different from RFC-v1:
>   - Drop idea of BTF "origin" (vmlinux, module or local)
>   - Instead to use full 64-bit BTF ID that combine object+type ID

> I've taken some of Alexandr/Larysa's libbpf patches and integrated
> those.

> Patchset exceeds netdev usually max 15 patches rule. My excuse is three
> NIC drivers (i40e, ixgbe and mvneta) gets XDP-hints support and which
> required some refactoring to remove the SKB dependencies.

Hey Jesper,

I took a quick look at the series. Do we really need the enum with the  
flags?
We might eventually hit that "first 16 bits are reserved" issue?

Instead of exposing enum with the flags, why not solve it as follows:
a. We define UAPI struct xdp_rx_hints with _all_ possible hints
b. Each device defines much denser <device>_xdp_rx_hints struct with the
    metadata that it supports
c. The subset of fields in <device>_xdp_rx_hints should match the ones from
    xdp_rx_hints (we essentially standardize on the field names/sizes)
d. We expose <device>_xdp_rx_hints btf id via netlink for each device
e. libbpf will query and do offset relocations for
    xdp_rx_hints -> <device>_xdp_rx_hints at load time

Would that work? Then it seems like we can replace bitfields with the  
following:

   if (bpf_core_field_exists(struct xdp_rx_hints, vlan_tci)) {
     /* use that hint */
   }

All we need here is for libbpf to, again, do xdp_rx_hints ->
<device>_xdp_rx_hints translation before it evaluates  
bpf_core_field_exists()?

Thoughts? Any downsides? Am I missing something?

Also, about the TX side: I feel like the same can be applied there,
the program works with xdp_tx_hints and libbpf will rewrite to
<device>_xdp_tx_hints. xdp_tx_hints might have fields like "has_tx_vlan:1";
those, presumably, can be relocatable by libbpf as well?
