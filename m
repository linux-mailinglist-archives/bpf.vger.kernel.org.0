Return-Path: <bpf+bounces-53705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0802A58A75
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 03:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763183A9730
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFAA1A23BE;
	Mon, 10 Mar 2025 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv0H9t4Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF59170A11;
	Mon, 10 Mar 2025 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573489; cv=none; b=bQ4RpGPCd/VaPRs5AnjSSv4yYJ2EqpYQid+OKLft4ogGHYjB9NFyGS2vAcMwlieYGsVpzYxDROUwuM28kCUsK2BPauV1goNW7I7+e/Ti0XyC7vbPynRE3Qt71aP6WvlXYD1Hu6jyNZ0HxqVRpXRrbJppgOdMARnIZTZqlQRIRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573489; c=relaxed/simple;
	bh=AIBUsJ/+UQ0z6zW9MVzwQe6CPRtiPuYH7kM/aGJmeAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azZDzz+RYWNvMAZx03VbVXH7VXQ13hlxZGPbH+yz7GrbIV2BJmZs48wilBtYZ7PUQc3xFJDxFTtxEckAwn1Vjo0t8AgX9sWquwb82hEjTjikMMBmyFniLczYob/ZxnK9iYMHzCZhAkxSOOYTy6gMAyNAIUGzDCWoSanQ+SotlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv0H9t4Z; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so6972091a91.0;
        Sun, 09 Mar 2025 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741573487; x=1742178287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UgdkfR5ZJpIqw3CxaKBXneuVyU1q32SHQHrzDgtsJo=;
        b=Tv0H9t4Z3tXZ09oTXqSxuhDREdnjojZ2dTqBVRzFuDGERFM6ivJFEhYRlIR9z8wEbL
         Bow1TEME1s45cyhgtzh8eChDsUVnFOaxzV8Qazk5XG2iBV3ueBfOK8pGV9OrNc3lv7WK
         uIrx1r0PLBXXdkdOQmneBVSXY/lHI1Cjs+pRX3+XbJIyKBcfnyWbLQ6OPhALdLiDvte0
         EJCNYa3IU9w41AQrCSuirxNydn6c5tiwzT6I2WoRu3QRxG0OsX+gwzROYtX0XuRu/fCu
         zWHHkc5OhkeFQulCAOX+PVB5ceKPEzPRhQ94ffe86Gde6FwuM6ADrunrC4RpvBAWgGXS
         JG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741573487; x=1742178287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UgdkfR5ZJpIqw3CxaKBXneuVyU1q32SHQHrzDgtsJo=;
        b=J+0BHeGf0S5zQNurGeP069xk4ZhwR5ZHKA4FZMVF/J8nNVkCLAJi6e8nLoqpxPlKQe
         YW/p7zvaPUTfYg+1ivsek1fQj9H7eQemqg/XaOSv7Na+0kVPzhYfYxk/M0Dq21cpBS4u
         83TkVKMIssJXZ7joJvBI27ERJhoVsZD6wj6YTrHhTvfLlkkBiBPEtQkU0+I0IKjdSTr8
         mDfdj3mWYktQ47k2crQPcp+67JE+7iK2c8jobYK41cK8m4jgeHTeNvDS/MMxokR4Fbex
         oBGDTjHPA0VpHOYUEOVR60cAl35CGmJTeCCNT9tDI3iA7b7NMHklTqI6gEnNsqdaAeAw
         688g==
X-Forwarded-Encrypted: i=1; AJvYcCUQqiTSNaf3MBHeT0ZQX09nFUFgcxH+CwhgotSe9mf8e3+sZn5+O6nrih83mZdsdvrCrCw=@vger.kernel.org, AJvYcCXhkqiCYtPC73bB6382f49J18SZgQEiN/yCvSYhiX3iA4BzF8eiX62S8KNixLxsUs0xmbAKSO64Gofgbge3@vger.kernel.org, AJvYcCXxm6U/05mWl1Q4q/c1P1E/GRZFBFdbIuGjBBMXW3IkhPINPfh/jiXTw+mfeu987ULLlmFV9ENu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8yRnCldkU0mgTSp8D9TXo8rEdpQt986Uszmu6IGg4DTyk/55J
	S2exBb0AuE2nVFYN5Ro3u02Ui1B+ka+wn8xF+D8NDzG0ltna+I2z
X-Gm-Gg: ASbGncsP7RQnKjYibuUE8JRPdbcVQDOc05TXYgh9zpeufKgwBomIvY5MypPVgd49q4i
	wDN0ekP+8/ePQn0kuVZKMGcp0SO07jOPg/57zhsbVR4xfXgNloh8D6VItVFtp42xlPDpode6+vt
	RBiu5k5pOhLdnZcJju7AiAENAbX+ARN+rz1l2Pi0e/G7KFVZ4xPt0QeN/dJDeGDHdafDhWrEPF+
	+M35sJChKmbe5LO/IWu5a7PDgoHPJblS7/dtjLHEb0Hfsi05nJYkcX5bFI+wMaTX2pzG94JOykg
	tlcQwjRaZSqiMlkI8YSWPvdf7BQjtU0/0J0MZA==
X-Google-Smtp-Source: AGHT+IEu8uuETGfMoaM3EPE2WfaTTndfm3F2AV9+L8B8fVo7WT9YAUCmxKGewCLzkt/NfrR5yWSoUw==
X-Received: by 2002:a17:90b:4cca:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-2ff7ce837c9mr21980902a91.17.1741573486614;
        Sun, 09 Mar 2025 19:24:46 -0700 (PDT)
Received: from localhost ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ffdd3sm8645058a91.39.2025.03.09.19.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 19:24:46 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:24:32 +0800
From: Furong Xu <0x1207@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Simon Horman <horms@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Russell King
 <rmk+kernel@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Serge Semin <fancer.lancer@gmail.com>, Xiaolei Wang
 <xiaolei.wang@windriver.com>, Suraj Jaiswal <quic_jsuraj@quicinc.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper
 Nilsson <jesper.nilsson@axis.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Chwee-Lin Choong
 <chwee.lin.choong@intel.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v9 03/14] net: ethtool: mm: reset verification
 status when link is down
Message-ID: <20250310102432.000032ad@gmail.com>
In-Reply-To: <20250309104648.3895551-4-faizal.abdul.rahim@linux.intel.com>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
	<20250309104648.3895551-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Mar 2025 06:46:37 -0400
Faizal Rahim <faizal.abdul.rahim@linux.intel.com> wrote:

> When the link partner goes down, "ethtool --show-mm" still displays
> "Verification status: SUCCEEDED," reflecting a previous state that is
> no longer valid.
> 
> Reset the verification status to ensure it reflects the current state.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  net/ethtool/mm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
> index bfd988464d7d..ad9b40034003 100644
> --- a/net/ethtool/mm.c
> +++ b/net/ethtool/mm.c
> @@ -415,6 +415,10 @@ void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
>  		/* New link => maybe new partner => new verification process */
>  		ethtool_mmsv_apply(mmsv);
>  	} else {
> +		/* Reset the reported verification state while the link is down */
> +		if (mmsv->verify_enabled)
> +			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
> +
>  		/* No link or pMAC not enabled */
>  		ethtool_mmsv_configure_pmac(mmsv, false);
>  		ethtool_mmsv_configure_tx(mmsv, false);

Reviewed-by: Furong Xu <0x1207@gmail.com>


