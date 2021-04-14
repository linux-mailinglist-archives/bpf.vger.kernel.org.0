Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8E935FC4F
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhDNUHX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 16:07:23 -0400
Received: from forward2-smtp.messagingengine.com ([66.111.4.226]:46161 "EHLO
        forward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhDNUHV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 16:07:21 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailforward.nyi.internal (Postfix) with ESMTP id AD2801940B63
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 16:06:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Apr 2021 16:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :resent-date:resent-from:resent-message-id:resent-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=L4V+u2t/aM/vd0lI2KEXE7hwFXJ7R3bAP/cs8cDjY9Y=; b=AAiZd0HU
        lHAsmVYIEPqoMeroA781vjPAn4umdMnxljx9DIc+NaMc9uMX+DXRX3kvDVw6c1fR
        BhVWzWcpOwzVCJNuq5z3SrHlY5goulwO84cADrFbY1nhBx1JZDYyJsZsYr67J8VD
        a7rdFSOWOZK3Gd6bHeSx7Ixodmk2cP8cq2FfuWeFrtPkCVJXqEcrcFxEH/R4Vzr3
        PoTJD70yHJC28HpeQcTkcsUTTKtefwHsmMiL5p7CVzVP1rmQAEGXWjrnVXem9bOq
        2koSiIQwSZoZiieeXzr1vRUg+Z8c56XRTJJkZ8WCOd01z0Kdr5zfvh7HApXliwW0
        g15DB71KjfBCrg==
X-ME-Sender: <xms:Ykt3YHB3xlgkXoWfUdRdQkrrjutRnSjRiV2jhvEU4SSonvEorXqc6w>
    <xme:Ykt3YFT-2T_FkJ3qXFqCYgYua6mFt6-Qv5N3Nu-qibeIy3DXjkpJeyjeiW4AfDafD
    M72IhKrOkHE9OW7Rb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fugggthfgjfffgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeftrghfrggvlhcuffgr
    vhhiugcuvfhinhhotghouceorhgrfhgrvghlughtihhnohgtohesuhgsuhhnthhurdgtoh
    hmqeenucggtffrrghtthgvrhhnpeetveeludfgudeuuddtiedvhfeftdefieelvdekheeg
    geduvefgheegffdvhffhieenucfkphepudeliedrvdegtddrvdehhedrgeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhguthhi
    nhhotghosehusghunhhtuhdrtghomh
X-ME-Proxy: <xmx:Ykt3YFo9IsKL45Db8gv-TsAwf_hot9VCPuydOwdqjPEeclmTMp-kCg>
    <xmx:Ykt3YHx8PBE0jrJjE5GTPnyBFnf-y_XiY2U-ww9pNgZGLSDnfRWdIg>
    <xmx:Ykt3YKJyu2YjwmlBwCXg03INWGsIu7z43r5w8tnnnvzAEoIl9SybTQ>
    <xmx:Ykt3YOS4ML5pSSIWQm78akgCbB0oJdx20Jl6FND5gzjCqduDVCDb4Q>
Received: from [10.6.1.116] (unknown [196.240.255.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B2441080068
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 16:06:58 -0400 (EDT)
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events
 support
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Content-Type: text/plain;
        charset=utf-8
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <4F445042-0ECC-4654-B334-E2364B5B9B8D@ubuntu.com>
Date:   Wed, 14 Apr 2021 17:06:56 -0300
X-Mao-Original-Outgoing-Id: 640123616.453848-dfc0680bd4f80b0b91aa9776b0d7e4d6
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC2E4B90-D19F-4B6D-A46F-6DB89E123069@ubuntu.com>
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
 <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
 <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com>
 <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
 <4F445042-0ECC-4654-B334-E2364B5B9B8D@ubuntu.com>
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> And kprobe perf events works fine without playing with them as long =
as:
> /sys/kernel/debug/tracing/kprobe_events is always 1 (should we enable
> it by default or consider it is enabled and don=E2=80=99t change its =
value ?).

Small correction: file /sys/kernel/debug/kprobes/enabled should
be always 1, and not /sys/kernel/debug/tracing/kprobe_events
(obviously).

-rafaeldtinoco=
