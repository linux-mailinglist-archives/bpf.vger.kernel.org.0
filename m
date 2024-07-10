Return-Path: <bpf+bounces-34358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0192CA48
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 07:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80DC2820A3
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31252F70;
	Wed, 10 Jul 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NqUPNN5T"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C06A47;
	Wed, 10 Jul 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590753; cv=none; b=rAW+9u+rzlArhd0wc36igKNaclkdzF01wNbu+nuVMMyS61b22JaM6kXAcXfx062XuQsOQytPGmKf4S4YuZxUswnClHkOZAOVy30tAMje6JQ29vWSE8wUrFUUMokHQTllvX6X6dA1RPBFBCJXUPEedoAV9938IR+KMh5thsJcz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590753; c=relaxed/simple;
	bh=zlcsbBAoVyNH0puUuwDP6S2gLhIe9lp4DE6MKlw6uMY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kj/0h/s2lQwNsBZyEcFCsX3UWmAr9gUMjGXL5brM2cBBb2bxkSD2dUHnztJOkbpqps/0hhZ5EqRi0hm67XrLSUfG3Lf5eU/cbg5gBPtJvjgmmgVYh23QCvzYdJE2Bqc5yOF5Cd6Z3OhXjOOwQsxLAL9GU3JwKQBqvbXGXSvZdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NqUPNN5T; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KH1Gi019428;
	Tue, 9 Jul 2024 22:52:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=CCrqCOGFfJNvbpM06coHjYcHCzO9TQf/b6LosmSTqHs=; b=NqU
	PNN5TqEz0an+/VGVcyCi1IKYcwiBQQgudP43J0ifgr/hZ+OyGpqLGJwqjR08hMfn
	VTNisnHN8Mi0umAQLua+06w8wcZi5pgoJl2opmF4NtrvVSlDxiR5/nx4yWqXTlK0
	YVxKS4qlJuslnwOQQ892JmdrR1RiCvB6+Uu5OwRDI7+M8NqM5PeO6xSZXedj46de
	K2dhFZ0Avz3L2PZa5pyVofbMnI42TgzxcMPijxDTFmRbOFCSqvQ2A1dptioEAQK0
	MFsWNqrohE/dUlUUIHvsNUEZO3Lqp+3+wsjcdyu3J99PKOORi5EekngJXgmoVpmI
	obDyHPF/ND4amGJig1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 408ntyp6en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 22:52:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Jul 2024 22:52:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 22:52:06 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8FBD73F7092;
	Tue,  9 Jul 2024 22:52:01 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:22:00 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <netdev@vger.kernel.org>,
        Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>,
        <magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        Shannon
 Nelson <shannon.nelson@amd.com>,
        Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 8/8] ice: xsk: fix txq interrupt mapping
Message-ID: <20240710055200.GA3213393@maili.marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: 9zgYQbcTYgVpfUQskUKKh6PABqQmQ2me
X-Proofpoint-GUID: 9zgYQbcTYgVpfUQskUKKh6PABqQmQ2me
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01

On 2024-07-09 at 03:44:14, Tony Nguyen (anthony.l.nguyen@intel.com) wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
>  {
>  	u16 reg_idx = q_vector->reg_idx;
>  	struct ice_pf *pf = vsi->back;
>  	struct ice_hw *hw = &pf->hw;
> -	struct ice_tx_ring *tx_ring;
> -	struct ice_rx_ring *rx_ring;
> +	int q, _qid = qid;
>
>  	ice_cfg_itr(hw, q_vector);
>
> -	ice_for_each_tx_ring(tx_ring, q_vector->tx)
> -		ice_cfg_txq_interrupt(vsi, tx_ring->reg_idx, reg_idx,
> -				      q_vector->tx.itr_idx);
> +	for (q = 0; q < q_vector->num_ring_tx; q++) {
> +		ice_cfg_txq_interrupt(vsi, _qid, reg_idx, q_vector->tx.itr_idx);
> +		_qid++;
> +	}
nit: why we need a new variable just for "for" loop ? qid + q wont suffice ?

>

