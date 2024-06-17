Return-Path: <bpf+bounces-32264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D990A25A
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 04:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A2B1F21619
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAF217836E;
	Mon, 17 Jun 2024 02:12:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-02.21cn.com [182.42.154.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C33176AAB
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.154.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590367; cv=none; b=Y1W5qTxEcthOK4fddyI7iy+/6gup2Bq1+PKPomKN08P/buylXTn9OKf4BL/gFA85V7By1POnoHvSSx/iXIMCR61oxFf/UattXtmjl81WXqAYT2hO70pEkivF1Yqw3OTqc/1+jcHp9axCGgCYPSwt7IREwats6sMG9Uk3cVRY05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590367; c=relaxed/simple;
	bh=PluLJvMYFbuzRMeyjfYCVbWE2ne1qhu44mhWN4LcCJw=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=fmQsfFeIOJq1axYmJaNy2kEaHJppeBnDSWkD2kUtX6ekDa4VMYJfa+ryS2ctS17h8dTampqOCdlXwhqSHc4HRWHheEYMsAcTYcBD21nViTa7mPGYkrcjE2P5dvr2hD6nJoGY8JqxixQTFM7PIGMx5ALZz2jcVo/YJ76Nomf8cps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.154.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1526860973
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.70 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 72D3712000087;
	Mon, 17 Jun 2024 10:01:03 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([27.148.194.70])
	by gateway-ssl-dep-67bdc54df-cz88j with ESMTP id f0b6e193ec5640d5ab51bb43a3cc68f4 for john.fastabend@gmail.com;
	Mon, 17 Jun 2024 10:01:06 CST
X-Transaction-ID: f0b6e193ec5640d5ab51bb43a3cc68f4
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 27.148.194.70
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
Message-ID: <42dd5ee4-fb01-4b84-9418-65adb7480138@chinatelecom.cn>
Date: Mon, 17 Jun 2024 10:01:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Ctyun AOneMail
From: =?UTF-8?B?6YOR5Zu95YuH?= <zhenggy@chinatelecom.cn>
To: john.fastabend@gmail.com, jakub@cloudflare.com, bpf@vger.kernel.org
Subject: [issue]: sockmap restrain send if receiver block
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hi, In sockmap case, when sender send msg, In function sk_psock_queue_msg(), it will put the msg into the receiver psock ingress_msg queue, and wakeup receiver to receive.

sender can always send msg but not aware the receiver psock ingress_msg queue size.  In mortally case, when receiver not receive again due to the application bug, 

sender can contiunous send msg unti system memory not enough. If this happen, it will influence the whole system.

my question is:  is there a better solution for this case? just like tcp use sk_sendbuf to limit the sender to send agagin if receiver is block.

thanks very much.


