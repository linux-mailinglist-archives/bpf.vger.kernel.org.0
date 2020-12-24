Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21F22E2543
	for <lists+bpf@lfdr.de>; Thu, 24 Dec 2020 08:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgLXHiJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Dec 2020 02:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLXHiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Dec 2020 02:38:09 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8AC0617A7
        for <bpf@vger.kernel.org>; Wed, 23 Dec 2020 23:37:29 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b64so1496382qkc.12
        for <bpf@vger.kernel.org>; Wed, 23 Dec 2020 23:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7S1VNj0uTb/MJfvKq1LUlvfvpbeOc2dUFGeGmoStAm8=;
        b=y2mAMKLBvkKfyhdrzexVASAiK4vVWCJCZ1hJFltArLr3X1Jhz324nsnHE0Wxu7AGxF
         WIJhWKqkDLQKQjswtS0LBcPfkDId7FmhXya+y9k0gjUCuVMvutc9Ow/zxNrd8e+HmCEd
         /cTqjKf9/xenfIRkxwMQkoR8gmSpIrFtVSqzv4szfTC7xVKInGpy69Sfy7rbYzp+SOdW
         DqJhOaoIPepTc7To14a5hcr0B4fwSjruYLh0zcEY9H0C5SiNhgsXDRp4HjrVnXccHMz9
         qEh8HOWFDuCC2ayKu8FDr9fevYARazKo7YQLnxKInxu94x4Py+fTPWLRSlT3/E3TuOzl
         f6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7S1VNj0uTb/MJfvKq1LUlvfvpbeOc2dUFGeGmoStAm8=;
        b=eLvM+Wg1uIbe68rVaMnZzHQMZFxqrQMkwRu9rQrmJhwkRGrsgrjCVrn0tNHF8M2CMl
         Uh436KBHAcR9WyntSchi/Tco84bZ6Bcd/5VuIww9u9aJ0WAI/uBINIYTTr7aV59umhAP
         GZ0JiCB+oKx33xrnvD9eNVCyWoS4KB5DLluriZWEKigJrT48a4vYOpaZpDYlZQi96q5t
         mjdrsRDvO4XYeUlGHpGDBpg1aS8/jN9qriDxKhag+VfFC3ccwLqSpkquLfR06mfIYTXx
         Twl4yc2AsxSdd6fxLo5+Xo9B78YzKtvfANC2Etp9L9sflAO9oS92SRuTZ4G3ohildr2m
         HAww==
X-Gm-Message-State: AOAM533oHNS4V6qP+AgKJvsQ3YoezywN8Bke6eT12kreZVbAc4wPPESE
        p+TjVaY6vg/mv02wjOxv0jEhz+DUm5itojFHEZr9xg==
X-Google-Smtp-Source: ABdhPJzQQ4GzEZTmGKjmIbLIe0upxe08WCOP6ndJIIbMwHsp06H66JTTLqM7gjsRc84WYR0Wz7EQdFZ/EVzv53erssA=
X-Received: by 2002:a37:7981:: with SMTP id u123mr21185427qkc.360.1608795448285;
 Wed, 23 Dec 2020 23:37:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608670965.git.lorenzo@kernel.org>
In-Reply-To: <cover.1608670965.git.lorenzo@kernel.org>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 24 Dec 2020 08:37:17 +0100
Message-ID: <CAPv3WKd-OFco5E56RtzO3QgJg-b5+s7ukVazUYSOtNBczQOViw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/2] introduce xdp_init_buff/xdp_prepare_buff
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, Jesper Dangaard Brouer <brouer@redhat.com>,
        lorenzo.bianconi@redhat.com, alexander.duyck@gmail.com,
        maciej.fijalkowski@intel.com, saeed@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Lorenzo,


wt., 22 gru 2020 o 22:13 Lorenzo Bianconi <lorenzo@kernel.org> napisa=C5=82=
(a):
>
> Introduce xdp_init_buff and xdp_prepare_buff utility routines to initiali=
ze
> xdp_buff data structure and remove duplicated code in all XDP capable
> drivers.
>
> Changes since v4:
> - fix xdp_init_buff/xdp_prepare_buff (natural order is xdp_init_buff() fi=
rst
>   and then xdp_prepare_buff())
>
> Changes since v3:
> - use __always_inline instead of inline for xdp_init_buff/xdp_prepare_buf=
f
> - add 'const bool meta_valid' to xdp_prepare_buff signature to avoid
>   overwriting data_meta with xdp_set_data_meta_invalid()
> - introduce removed comment in bnxt driver
>
> Changes since v2:
> - precompute xdp->data as hard_start + headroom and save it in a local
>   variable to reuse it for xdp->data_end and xdp->data_meta in
>   xdp_prepare_buff()
>
> Changes since v1:
> - introduce xdp_prepare_buff utility routine
>
> Lorenzo Bianconi (2):
>   net: xdp: introduce xdp_init_buff utility routine
>   net: xdp: introduce xdp_prepare_buff utility routine
>
> Acked-by: Shay Agroskin <shayagr@amazon.com>
> Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Camelia Groza <camelia.groza@nxp.com>
>

For Marvell mvpp2:
Acked-by: Marcin Wojtas <mw@semihalf.com>

Thanks,
Marcin
