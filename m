Return-Path: <bpf+bounces-56768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D1A9D93C
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CD81BC7BC1
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FD724EF91;
	Sat, 26 Apr 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbKGZZEe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F281922D4;
	Sat, 26 Apr 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745655225; cv=none; b=S5bYfEXw89D4rsURb6qVlfrHdpa9g04afoxLXAZv86YJ5cCSlo0hF8IjjAPQIyybbD4SSKOBnCllCyn60RgsWct7U37iX3lElp5YqfZ3uEJka7Enox03zEFxYkQFRn/WeuMFhEOBh6D6YRwjhzHBruxe1zxVocWCT3Gm0a1GhuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745655225; c=relaxed/simple;
	bh=NOoqkO+zz1eeFYdOVt3Zh1aQaTUST3R452WF15ma55o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXGfl+391ct9gcUAEzZb1Nc8M5+vrtYbW45EoO/1eKOG3OyWeJly/0v39yvqv6QdsNM2784XiTW7doJdB6NhqNPuOPpLB1x30D8eqdykwYRjc6jEwUIre+ZiLr/YgzvoPb4SdcWNLT7gzq+n2fax5NrSb2i+LG8nxCZ09nrfmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbKGZZEe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so2705909b3a.3;
        Sat, 26 Apr 2025 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745655222; x=1746260022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvvbhvACfeE0d7OS1ELo9a7xaL7zTrcX+KxjV9AKeRY=;
        b=mbKGZZEeugRzHtX8ri6R5nSZ61LDmRbNIg05uR2RB15BUWe8FhgdGoi2Hsx6loeftN
         1/i1rpUNMk9Te97o5gTlri2wF1ypkeevOCAlcwgor8za57VBpoU+ZDfqa0+hcy9y1u2j
         zUS2HuLMPgUtrMp8AJqWedoGtAMyHq7hDhB52oVBFdqgsy0a2e/aT000mOnlE3tTIRu5
         zlAA7nR2tif3lp5tCn53dMFdO+rS4DdEricYpDef7mhgUn2masZTX/lvY2CGupMqYvo5
         HqnycjSAeL/Cgfy/s8Gh0mLXtUd/OlXHLWmZVEVG+q+2IU1Q7NFNJNoUhzdmv3eyEnaL
         Dk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745655222; x=1746260022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvvbhvACfeE0d7OS1ELo9a7xaL7zTrcX+KxjV9AKeRY=;
        b=TDuZob9sKnwv94ZGEcN++sIblZDCC+4bTwCPSPIRT5H/e9iz0v3khhHkR8X+hHNjjK
         Na7UQjqof000VbvYir8fwB1txTpRsiOqTJR/K6kDBTv26O5behtk8T37KGRUIzD3Y5cU
         x1e7TxZkQc+iAJtqktKD2+Ub18sSyvfy0EfTTyfYf7+fs6gvWgUrMu5LMVqueCn/QRgk
         Zg0RHsAsaPoqMI6jWoRlajgHreZ0KkrFxOg3JTRTkNsaA5o6f7cqLCxpC5Z3STL/FLIP
         IX0Z7Gsz9Lyo77tkxy0IZE6B9Ni2OqOfL73+kl0sYHjs5DAwDNSvxvWCzdLWg/AbrT9I
         eafg==
X-Forwarded-Encrypted: i=1; AJvYcCWGqlcu9tGpJk02stP7I4OFc8nll5VKqrow+o+em5zbrif79WgaeV8rWMWuo3OYFCGd4UI=@vger.kernel.org, AJvYcCWxkrr3q/u7bKqghLQXzwH25CafsGdmRl7VtNNhS2KD5vIf9qGp3vgZ3BTga6VqCbysPqLHfmgD85EJvDAF@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBGl6XVs626StNj2FoBnvg80n4PDxtsZ3yDADkLU3qtjVtEna
	PVbGWOIjTTkhKfdniSmmc4lgW2Vc6p2oHleBI/eqvni+AtF0iPcGRHuNTUMS
X-Gm-Gg: ASbGncvl5eETVFTlOAh3IUSCpd9J7siBtyZiIQ4EcRfvfdvr7UqIT1cz7CyBjks9QkT
	//DjG7qVLqQWgjWoDkwyhEDF/d1Eb6a9jURNPVfOUH2jv58Rhv6bq6vWUu5b5Fdo8VKJq2OtKbM
	cw4WCMLy3Y4v2VGIz9p4fBzS6DSF5BxaB1hHujFDM3ShUI6YuXjZoX48qX19o9jmT38pDWD5EUm
	Li8LMDUgM2UCUyKHkYhyWbdzrDnRzdpaFVtkZLe/VOwL0t+eZkXi7y30WzIE2DrLKP0Eh/bkfUs
	QroK/ZxgF2kxmWNjfGEdQnTcCydeNiFZJ+CklZWcOThHtwwkBdOqCgLp
X-Google-Smtp-Source: AGHT+IFz1ZiIYco42Yj8rxuh0jm8GrjxmOyjIZConlJzyLKDnmQjNC/3puibLi5Qt6eudH1z7jN2AA==
X-Received: by 2002:a05:6a20:d04e:b0:1f5:52fe:dcf8 with SMTP id adf61e73a8af0-2045b99e15emr8022451637.26.1745655222155;
        Sat, 26 Apr 2025 01:13:42 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52b1:1f45:145e:af27])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bf7sm4503700b3a.68.2025.04.26.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 01:13:41 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net-next v2 0/2] xsk: respect the offsets when copying frags
Date: Sat, 26 Apr 2025 15:12:18 +0700
Message-ID: <20250426081220.40689-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

In commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb
conversion"), we introduce a helper to convert zerocopy xdp_buff to skb.
However, in the frag copy, we mistakenly ignore the frag's offset. This
series adds the missing offset when copying frags in
xdp_copy_frags_from_zc(). This function is not used anywhere so no
backport is needed.

This series also makes xdp_copy_frags_from_zc() use page allocation API
page_pool_dev_alloc() instead of page_pool_dev_alloc_netmem() to avoid
possible confusion of the returned value.

Thanks,
Quang Minh.

Bui Quang Minh (2):
  xsk: respect the offsets when copying frags
  xsk: convert xdp_copy_frags_from_zc() to use page_pool_dev_alloc()

 net/core/xdp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.43.0


