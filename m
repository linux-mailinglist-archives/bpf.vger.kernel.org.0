Return-Path: <bpf+bounces-53329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D614FA5021C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02FD7A8966
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF082505B4;
	Wed,  5 Mar 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="cKr1s9UP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T8GsC2r5"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90F1632EF;
	Wed,  5 Mar 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185215; cv=none; b=sSbF0RByW/NYGn9FQyZbL39n5daxyTjpv+meQgPqiIScylUx9I52tsiyvWHeh4BAEWMQIOjI35Wt/5EwYIAuOWXhEjLMmRNkbDaWv87Bvxu1zvNAvphkFzMQ1RPSfcp8Jt3HDyuzS/C5sZLa/40Sopp/id03yq6/C6na5s3Oyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185215; c=relaxed/simple;
	bh=88EbAv9wA20xdpCHpwGY7DA8RnfPSAiZ3mf1GSiOwp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCSsAfPQGH5BZuIjh3hL2090asfxwbLmuQb2mNSz2PlYZnfbaNd/QdBQgYt7U/1Hq/hRuK3mZLS3Lw0At1AvTvzWYC6l1sTUww8Mwf5VkQm79uKQoCB0TG0ZbXIaPlpmm2v9XAt+iDm1CLu9MDpZa3bmMp6+ujFJKpe0ZJpqCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=cKr1s9UP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T8GsC2r5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B66C13826A7;
	Wed,  5 Mar 2025 09:33:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Mar 2025 09:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185213; x=1741271613; bh=nAdEtDrkHqUTwsOjy7M1AaSyH7jAnptn
	4P9ellHBC8A=; b=cKr1s9UPWvzfrMh7rHnucKeA3GoZl93s8iWZVTze0pmQyHFi
	9butLGG+/MtmIdAhamX2UZOGJuCVTyQ2gnx3650o8FtulYGOW0F3qwVfM01Rzn7b
	0LtExYNZGCd3NC2r63z9oEYmuS5uHvV332OS58JRMUQ/oNIJ4KCX9mw5HmDAXw99
	kBjqP8bvOrDpAYbN8Me1JBPvyL8Q0JjoRy9XlQtcUlXFYlxxxL6XB6qcZKB4z5BQ
	EWw6j13JhB9a4IYYL3248pOvEyR/df6EMC/Th8S2zAbCh5ImnXgTxF3nSGcG0fGz
	u371yIfTD3iToWNG3dcl5QJQHScpOsTnUpXZcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185213; x=
	1741271613; bh=nAdEtDrkHqUTwsOjy7M1AaSyH7jAnptn4P9ellHBC8A=; b=T
	8GsC2r5hQTPsgg2HdqDv8yR97mO9Un8Wm5Ls8pmDyQJl6F0sTGeMzjjkf1YktoDD
	zUlLCRhPTs4C9JOPbDxwvdR8/f1+ki07x4wmglGZh3/h0d5Uy7W+yJYDPWAaSdgn
	Ob0091JqRSLAHH8N/XXf5A+KO65Xpb+fxfepRJ1BfakFtye6HYX2vZPuzWedBUpB
	McO4vNLKhyve2pYdbspr62/VzyPrixifya3b+e9aN/cVapvPsHqtOn1nawNo6cJd
	PfSop1eIPpsOxbVvQiAS7PH2w4fzOrN+kR3jzL07GR9cl4v50YqfphECjSJfW+VF
	75b6r5CW2udoJvX57H41Q==
X-ME-Sender: <xms:vWDIZ-sILCWCvN3EdR2_dR5TgyXfY5UUAgSHg5Q5m2HJdX_kroZylg>
    <xme:vWDIZzcKXa5R7xqqnXi_0mDWBIXFVNdVU2-VlUxVLS8Zqmg0gvhjfeC4-owEqfV8s
    7uYQQVcNINqvsLD1O4>
X-ME-Received: <xmr:vWDIZ5wb3-ipru__pQo1hfk7nNYvLT8QRxBQ2NPfo18KEjPU3iE9JDBDIceAxyYHPR56rOAo0AenC1bNJns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:vWDIZ5NVgJoPfKbyBHnvpU16OA7YgpDZ-b0lplfzVml4JGZb6SY0vw>
    <xmx:vWDIZ-9FTq8VFXyv8X8mXOtRy0Y_4bcWzprdVg30uOMhwkJpm2uxCw>
    <xmx:vWDIZxUdYzIYDe1J-TpcHFKxQAZgm7ckWY5NHc7aNz5jV01KlbKPpw>
    <xmx:vWDIZ3fRTfgmyPnjHCpVFz3YeVyLN8WkpTt7CsvNelfji4eSB2LY6g>
    <xmx:vWDIZxYB8j59V7jVATp68am_7m8Tj1B67LRsBlgwInc87J-HAxS8LW-W>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:31 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:06 +0100
Subject: [PATCH RFC bpf-next 09/20] bnxt: Propagate trait presence to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-9-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Call the common xdp_buff_update_skb() helper.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bbe8885543a7c612567f7ff55a4fca..7e22804ba09b5a12384a0f8125db42f79b187d42 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2273,6 +2273,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			}
 		}
 	}
+
+	if (xdp_active)
+		xdp_buff_update_skb(&xdp, skb);
+
 	bnxt_deliver_skb(bp, bnapi, skb);
 	rc = 1;
 

-- 
2.43.0


