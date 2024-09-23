Return-Path: <bpf+bounces-40183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC097E58B
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 07:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EA62813BC
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 05:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C3D12E4D;
	Mon, 23 Sep 2024 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Kall8Ect"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0122107;
	Mon, 23 Sep 2024 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727067784; cv=none; b=jgnwxg7zXkru7W7aWbqKTtZ6b8NUcbcihc1cKZhZ6bArtSx3ZfNUKe8ozwBirLZc7I7Hj2BclxgpHnvpV43IVoK3bhI3ajICOsOowA2xUihhbvDrwjk8yzcb+JYo6mncgONkRucxe4F/LuwfDCl4DECsiUfy+DAWiXDkLbVN6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727067784; c=relaxed/simple;
	bh=B3wwTON+qTShPAZZC+AoAZ69jsRudU0MkiG3Cj93gTA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTIHs7rGPkytqPVxpCnunjoPnimUEJr5PcemCXxAXIBUGtQDGPrB8zuTeqzwl0USqR9CUPV8lhsUI7qz3SR5P4c8pRs75nF9Zc8AZPg1+pungMhiGmJXM1+YCYn3JY8DU9jhwAY6/Bn6PsIA7mE5b8hARy9okO4j48+nOoquRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Kall8Ect; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MLfxuU018075;
	Sun, 22 Sep 2024 22:02:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=B3wwTON+qTShPAZZC+AoAZ69j
	sRudU0MkiG3Cj93gTA=; b=Kall8EctE1w1RfxJfVUmquPRJSh9I9oIaP2IY7Xb6
	uv4IR1K24E0wQ/LfvPeCW1a/Ebye4oKV4OyQedL57nuiwtrhQVhvuariWgmbaOs9
	Q5U3ZH0Y3ythuweB8sMXYa6weUryFCGS2oA4J4Gpc5uANWIVhaWobiyoL8/Tpgkz
	v3QQxycMgZ0wYdU8yz7Nukb9teUOqnaDdwrxnRXmhjHtuuy+jR9Pk3yJ1oOVPuDE
	Br5+tsVBqcmARgAb2MelQ9bL/EOPedH0ULW6g6RvPa78VzeMlpTNUyyc9rUOzZuL
	Gsdc1Y5QkZ5HPFRhQYWNma61097eTME5ruwGzb1bY1koQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41sugnx587-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 22:02:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 22 Sep 2024 22:02:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 22 Sep 2024 22:02:35 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 32ECE3F706C;
	Sun, 22 Sep 2024 22:02:30 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:32:30 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <claudiu.manoil@nxp.com>,
        <vladimir.oltean@nxp.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <stable@vger.kernel.org>, <imx@lists.linux.dev>
Subject: Re: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from
 enetc_xdp_drop()
Message-ID: <20240923050230.GB3287263@maili.marvell.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-2-wei.fang@nxp.com>
X-Proofpoint-ORIG-GUID: 0TgZ9baRa-xp9wqHsobwz1PkZFMnPTWb
X-Proofpoint-GUID: 0TgZ9baRa-xp9wqHsobwz1PkZFMnPTWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 2024-09-19 at 14:11:02, Wei Fang (wei.fang@nxp.com) wrote:
> The xdp_drops statistic indicates the number of XDP frames dropped in
> the Rx direction. However, enetc_xdp_drop() is also used in XDP_TX and
> XDP_REDIRECT actions. If frame loss occurs in these two actions, the
> frames loss count should not be included in xdp_drops, because there
> are already xdp_tx_drops and xdp_redirect_failures to count the frame
> loss of these two actions, so it's better to remove xdp_drops statistic
> from enetc_xdp_drop() and increase xdp_drops in XDP_DROP action.
nit: s/xdp_drops/xdp_rx_drops would be appropriate as you have xdp_tx_drops and
xdp_redirect_failures.

