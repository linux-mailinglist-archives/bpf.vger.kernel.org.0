Return-Path: <bpf+bounces-47111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F39F4667
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE78B18844BF
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303311DDC35;
	Tue, 17 Dec 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbLX2/Rh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7D1714BE;
	Tue, 17 Dec 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425174; cv=none; b=sV+AYMYzSa/1GSaG2V9P4GShEZ3kSgFSD1dkpIQQwB3c7024ezBFPqIyiWOofLvW4cse944cIl3sj1IxsGJhyNZlkNhsTFusQkJiGWBGvr5mGccJWqFX0Mf+bfPHKY6R/j0rRXBIo+wsGwRfHMFO/BFeDcYZ32eCn6u3mBuiB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425174; c=relaxed/simple;
	bh=2MP+waN3js1IP5hQ9c6jLyb48oqtoqTUAX3rOoZ+ThE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0xbka+KaOHOnuNKId9gpwG0bvVKonQnSXido08V8TYdngVGXFDv092PbgnGS4w88ux9NIXUucy9WeOQeLAA/ExtQnz3H5NVv1LJIZ42mLgz8WBLCfTnSGs+UpfUPDvdKyI5YEX8ylo/JVFt+1qgPSc+R+EenRSxRH5W/vb9S6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbLX2/Rh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436203f1203so4458095e9.2;
        Tue, 17 Dec 2024 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734425171; x=1735029971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DANgJX5B+e8ghUsL1ks3H+WRdxDzAQe7jNh5Uly4bsE=;
        b=mbLX2/Rh9tLrIc/SbnhoxdFZ/EvTO+x+Uv7Ka8WoAckCAgB9WGBCO6RKrIRab/kS6i
         VF31iO5gE4xNuY/+GJ0CesjUmeMQs3ESURYad/5A0LGcBHLVz87qiz0+a3jwtEEcXXcf
         WuvVUJInL5ChDu7EP8Jv4hicwq9mQxg+b3asvrbdNlTumD87RTALRAnAtI0Q4qI3jQQL
         hvt1r7JhAg8OZdP+B6hsnNPCO0fFuCCWbt8BTHc6fH+eOz2qwR2GBbH6RprVqn3nH7Cy
         cK8MlMa9HyFky7GjGYqdKMWHWlZODsaEEC1Lcu3Qs83mO2D8OAjiFg24sUlbkwMpyg1Q
         CrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425171; x=1735029971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DANgJX5B+e8ghUsL1ks3H+WRdxDzAQe7jNh5Uly4bsE=;
        b=hM3zwQ0gVv1Q/d/YH1b5eZ34m4fGFcMOx8XQuCO/dc+uwXddwLt2Lip10QUgVtRdJV
         Uw9DjFfw1khmfYyDoRBoQh/9yDHS3z2s791TR7W3DxE0sz1lBaoXUO/Ma/IBgPedo1oj
         BhditfHbqsrsJDg244rpQ8+qehsaj/+wL3/sDL+BD++sQq+Cap6kYLAdo366ywi1QMLP
         0PpC94G/IYX8clf6xbbldFGolahZQLMzUxa0C4XPnOWhj0w52l4nSmxFm6qE6yQyNjM/
         YDCDtRBAFAiNjj2muVj8Gwdk+70o5U5y1jyt7wfWVM9vHHWLaQzxKZGHNjUKyAL8Ooxq
         FbLg==
X-Forwarded-Encrypted: i=1; AJvYcCVEhWr0ltXTGx62uNvfV3HIMsTYRAek0dNK55TJ2PeIyMg0qH5vamNgbISOG4KBw2MWj+E=@vger.kernel.org, AJvYcCWNpS3nG+2I5XkhIFLHyZk1XlH1leiarSf//YAGWenkpWnm9q6CUWChii6unyzbjo6lgQQaEM8z7GXJrT5q@vger.kernel.org, AJvYcCXz9lz6fFHgehGyEDGoXURI9nnJQ75kMGQdG99Ge8oi6joN1s2jcHAfD7BAzQnV8XpSNmPKry79@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9RACK7aT2FzwLNhv+vqJOnJxxu+ouI8Hagrgy9xX+NIQKVpH
	xAaZOGBCpmP7lcIjK68jRkmOkxL2hQY/EooYZbqgft0c2DmVqF/Y
X-Gm-Gg: ASbGncvLRfURii0EKqXaEuYlIacIa5EAG4enj/U2vHmtYOR+RFjZrwseS9zpoQllzXg
	EU46lC6yM74mnkVR+LRh01CjcY+IH+D+Zl/kCHqDEiBp3Nh11rHnBVtwyqs201zrXw5zO7MK8is
	sZT1RzDXbNfx4osqF10NjIAHoNiBEGlAV0tdIpYMpIOAndfPlDikuPFDY0OsrQWjLULdjMIwk32
	R0B0DwQzh6FhqHMNlZojg8H5LWv+yGkZ7DWn0xs3Lw2
X-Google-Smtp-Source: AGHT+IGO3QFP0qqBnYh1mqcB6H4pNm+oGioUq900aBrsRIHsJrRzcrb969fkxZI5Qt2wJjRhv1ydDA==
X-Received: by 2002:a05:600c:450e:b0:434:f001:8680 with SMTP id 5b1f17b1804b1-4362aa26e0emr52929955e9.2.1734425170963;
        Tue, 17 Dec 2024 00:46:10 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b0566f1sm10142665e9.2.2024.12.17.00.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:46:09 -0800 (PST)
Date: Tue, 17 Dec 2024 10:46:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Furong Xu <0x1207@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 6/9] igc: Add support for frame preemption
 verification
Message-ID: <20241217084606.3lbne7kv4rlkhoct@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241217002254.lyakuia32jbnva46@skbuf>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217002254.lyakuia32jbnva46@skbuf>

On Tue, Dec 17, 2024 at 02:22:54AM +0200, Vladimir Oltean wrote:
> I spent a bit of time extracting stmmac's core logic and putting it in
> ethtool.

There's at least one bug in this conversion:

-- >8 --
diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 3063fe00eef7..d305208dd0c8 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -292,7 +292,7 @@ static void ethtool_mmsv_configure_tx(struct ethtool_mmsv *mmsv,
 static void ethtool_mmsv_configure_pmac(struct ethtool_mmsv *mmsv,
 					bool pmac_enabled)
 {
-	mmsv->ops->configure_tx(mmsv, pmac_enabled);
+	mmsv->ops->configure_pmac(mmsv, pmac_enabled);
 }
 
 static void ethtool_mmsv_send_mpacket(struct ethtool_mmsv *mmsv,
-- >8 --

