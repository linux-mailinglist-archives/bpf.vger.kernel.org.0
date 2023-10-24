Return-Path: <bpf+bounces-13141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 963567D5764
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3823B21081
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7411839924;
	Tue, 24 Oct 2023 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT/PRoLK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538C29437
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 16:08:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB3A6
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698163681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjN52sp3DALiOlG73yTeB0LvMITZMvs1P6Xx8F02nk4=;
	b=VT/PRoLKBimwK/p1P/k6xe+0zyfd6szjHsVjEE3o2TQRNwtoWr1dFtOIVdfnp6t7cNq5w9
	QhaPxQtp8T5IpEHZ8xkyLFPWOuPExbp8nusvO/WL66mFz1Mgp6PN+XWlNHtRzKSFOqauC7
	y3VcDP2Xx426qeB49AEa2SjFGTO3T0M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-ixPwigNWMJ6O7nl7-V91RQ-1; Tue, 24 Oct 2023 12:07:59 -0400
X-MC-Unique: ixPwigNWMJ6O7nl7-V91RQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso303972066b.2
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 09:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163678; x=1698768478;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjN52sp3DALiOlG73yTeB0LvMITZMvs1P6Xx8F02nk4=;
        b=OJKhHZtSKy9ufS/slvGsHIVOi0DXRxG3IN3WkZkrSwuv/A7xdXnNdrPaBTNS3GEpYc
         wGwF1Sgzqlq7ok2aq/69WJHl6+nm9ZOCONYuURQFW+Elm2kwPultdMl9QFnRAMK3C1v6
         qtT2+NepwuUOPxRw3rW/25KZ1e/C7r1rdFtwYHbSjj4eE/bJjELtJBLa3/xOVisTKiAc
         tLWqf2M2kmTuobUw5cpmTuLLHKJMFM1qbpztIBKMG0+r9EQEc7lOF4rssorewJFf42lM
         M6Itg53mtK4cBHNVtNB6psRbqDSM16Fr+aTVxmWlfqKXujpRM4d9cXxK1GJUt5Y01itT
         vO9A==
X-Gm-Message-State: AOJu0Yy+AcZETVROb23lh/PQ2YEj0vJa9u9kxBcUMKUfzW1sO6/4GxAa
	wpcAs1osEuDgY1ejmw/ii3kMQVs2FSLT3Bzpq9DGCPOOvd58gpxr14h5UH7OuiBFGp1qKxXyhTH
	fO9LSFurZ/PUu
X-Received: by 2002:a17:907:7f8b:b0:9a1:abae:8d30 with SMTP id qk11-20020a1709077f8b00b009a1abae8d30mr9227366ejc.47.1698163678365;
        Tue, 24 Oct 2023 09:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH71UJ0fiJyLaK2kn6BI171cL0QHtUrKb8VK2HsZ7+wdzh+157Ymr6NF1VaGZJu8/ECUuTCdg==
X-Received: by 2002:a17:907:7f8b:b0:9a1:abae:8d30 with SMTP id qk11-20020a1709077f8b00b009a1abae8d30mr9227345ejc.47.1698163677907;
        Tue, 24 Oct 2023 09:07:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gx13-20020a1709068a4d00b009ae6a6451fdsm8442848ejc.35.2023.10.24.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:07:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 00485EE2339; Tue, 24 Oct 2023 18:07:56 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
 sdf@google.com, kuba@kernel.org, andrew@lunn.ch, Daniel Borkmann
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 1/7] netkit, bpf: Add bpf programmable net
 device
In-Reply-To: <20231023171856.18324-2-daniel@iogearbox.net>
References: <20231023171856.18324-1-daniel@iogearbox.net>
 <20231023171856.18324-2-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Oct 2023 18:07:56 +0200
Message-ID: <87msw8ovfn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> This work adds a new, minimal BPF-programmable device called "netkit"
> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
> core idea is that BPF programs are executed within the drivers xmit routi=
ne
> and therefore e.g. in case of containers/Pods moving BPF processing closer
> to the source.
>
> One of the goals was that in case of Pod egress traffic, this allows to
> move BPF programs from hostns tcx ingress into the device itself, providi=
ng
> earlier drop or forward mechanisms, for example, if the BPF program
> determines that the skb must be sent out of the node, then a redirect to
> the physical device can take place directly without going through per-CPU
> backlog queue. This helps to shift processing for such traffic from softi=
rq
> to process context, leading to better scheduling decisions/performance (s=
ee
> measurements in the slides).
>
> In this initial version, the netkit device ships as a pair, but we plan to
> extend this further so it can also operate in single device mode. The pair
> comes with a primary and a peer device. Only the primary device, typically
> residing in hostns, can manage BPF programs for itself and its peer. The
> peer device is designated for containers/Pods and cannot attach/detach
> BPF programs. Upon the device creation, the user can set the default poli=
cy
> to 'forward' or 'drop' for the case when no BPF program is attached.

Nit: according to the code the policies are 'pass' and 'drop'? :)

> Additionally, the device can be operated in L3 (default) or L2 mode. The
> management of BPF programs is done via bpf_mprog, so that multi-attach is
> supported right from the beginning with similar API and dependency contro=
ls
> as tcx. For details on the latter see commit 053c8e1f235d ("bpf: Add gene=
ric
> attach/detach/query API for multi-progs"). tc BPF compatibility is provid=
ed,
> so that existing programs can be easily migrated.
>
> Going forward, we plan to use netkit devices in Cilium as the main device
> type for connecting Pods. They will be operated in L3 mode in order to
> simplify a Pod's neighbor management and the peer will operate in default
> drop mode, so that no traffic is leaving between the time when a Pod is
> brought up by the CNI plugin and programs attached by the agent.
> Additionally, the programs we attach via tcx on the physical devices are
> using bpf_redirect_peer() for inbound traffic into netkit device, hence t=
he
> latter is also supporting the ndo_get_peer_dev callback. Similarly, we use
> bpf_redirect_neigh() for the way out, pushing from netkit peer to phys de=
vice
> directly. Also, BIG TCP is supported on netkit device. For the follow-up
> work in single device mode, we plan to convert Cilium's cilium_host/_net
> devices into a single one.
>
> An extensive test suite for checking device operations and the BPF program
> and link management API comes as BPF selftests in this series.
>
> Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://github.com/borkmann/iproute2/tree/pr/netkit
> Link:
> http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkmann.pdf
> (24ff.)

I like the new name - thank you for changing it! :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


