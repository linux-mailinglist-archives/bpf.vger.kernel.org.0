Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22A32D3391
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 21:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgLHUWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:22:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51209 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728234AbgLHUWD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 15:22:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E000F5C0132;
        Tue,  8 Dec 2020 13:57:51 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Tue, 08 Dec 2020 13:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm2; bh=M8pV4upo7ii74Z1m3AgToI7ZZ4ezJK7
        OMZqHyoEiglM=; b=go4KlqL1DmnglLSwQgnaJv3DjgaZc0ll6Ear2WO2eBru6xf
        GSTV65cgWXBctcXTnFlvEM8yEGciQHVplUosmVYAE7LociA8HAm7tLGGverIL/xY
        hUGoSw5vbkYYTxzv3PfI4vfEsD1Eqv2C51L/pR45h6ls3yzw/xa62JBIt+5DDWrR
        o1dVpDJifgoNDWbIz+xP5K43ZyfXwY4GhVQxiFHdKbuoeWKV7iodlKb1EYqlBycL
        xzUPJxYsqNQU3bWsXnSyAKCEPQ4hYjLZVG7MDWv/LG88jy6W+3boi42FoofIW5Vh
        GMdBlgV9Tino1Cb4IEKqqLv/2V/ThCViMdW8o1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=M8pV4u
        po7ii74Z1m3AgToI7ZZ4ezJK7OMZqHyoEiglM=; b=OrrxGqQd4y9maIvSc/FWy+
        8jimWXxUjneaQ8hPv/32xLXGW5vf7KmoV4Rihr/K4O5qGLuiTzDxiJv2FBsmgkVH
        YD/8dLlNGdCCqnaTrHg/1Q+45Sx3MkpuvteqPtM6b2TreZVKf+WnzOumWvYqHlnw
        10OBAS3Ed+imqgYZqxDXRz289/lS1c7pDeza3OMU8Hb6RnK5SdLSeEt6gEgUTMrZ
        vE5YkJN7+7nL68eBVLfUFTPk9/N+TQMee2IzupIBEOwL4+QS9QKIQIorDW3tMG9C
        yLjXOhK8O6YyofM+o8p98fvUiJ5XXMH1TsFVzJkfc7q1h9uxYfHVXteGL3+HFaTA
        ==
X-ME-Sender: <xms:r8zPXwLnw8qsncfX2a2mlT-pet8_QOv8izZtzAzIrrf4bkoL4iDKFQ>
    <xme:r8zPXwJEw1BZ4XLQJ_vSNo6p0DHhacatRTn5gEpxd7Uw0sTfsI7zlIjzDo8hamns6
    ndz_KD9UrdnVH60pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeejgfevtefhjeelgfefvddthffffeeutdffgeeihfek
    teefheffgeeitdeifefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:r8zPXwsZdjcUXovtGjnjtfyUwuXclGnD6CIOSFSq-CTYXnoiegl5Hg>
    <xmx:r8zPX9b3z5zeHTG1RxjfhcA6S6ftZkEzyCdDCuBx-uMaTlJZO1uX7Q>
    <xmx:r8zPX3aOwuY1Gf9X9CGn7YKgBJGUFrmslAq2bpurJSTsv1AyUl-Rsw>
    <xmx:r8zPXx01dzJv8DI_66Gwl5I6WJDNfB_2uUXedP8PUsUEMHFzfAcucA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A6D99AE005D; Tue,  8 Dec 2020 13:57:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <919345aa-4746-40a5-be17-faf110619e84@www.fastmail.com>
In-Reply-To: <CANaYP3GdNhD56xykv+uS2Y1Mof1vXWkSfdbTPo9bwjGmXxSHEA@mail.gmail.com>
References: <CANaYP3GdNhD56xykv+uS2Y1Mof1vXWkSfdbTPo9bwjGmXxSHEA@mail.gmail.com>
Date:   Tue, 08 Dec 2020 12:57:31 -0600
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Gilad Reti" <gilad.reti@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Feature proposal - Attaching probes to cgroups
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 8, 2020, at 2:40 AM, Gilad Reti wrote:
> Hello everyone,
> 
> Are there any plans on extending the cgroup program types to include
> more probe types (or possibly allow restricting any probe type to a
> specific cgroup)?
> 
> For a use case example, this will allow attaching programs to the
> "docker" cgroup and thus tracing events from containers only (or even
> enforcing eBPF LSM on docker containers only).

Based on my understanding, this may not be possible. For example, the
kernel may lose information about cgroups on deferred work. When the
work is later executed, the cgroup may lose information on work it technically
initiated.

Daniel
