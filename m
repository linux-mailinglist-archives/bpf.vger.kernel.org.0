Return-Path: <bpf+bounces-78520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE03DD10C02
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915B530ACE63
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8431986C;
	Mon, 12 Jan 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TCIbV5o+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE77312825
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200540; cv=none; b=ESPu8G0EFHdd88o0B02LswYcvGO+J/mBSgw0AOwz8q+Ci6JPl0w0FUliwW0tGLREc5PXdJtbqI6+X8pI7zaq4X+gwZL3Mt358JrX7TRZC0xMr0XmJ195cDKqtKqaWUQG721yqi+SnUYjEvqV+7mK8pSITooPfehVF9hw0hqXaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200540; c=relaxed/simple;
	bh=PORkVXvg63BpdFWitYBmyQs8mKiAi/bQ6d/kl3dALsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hI1k2vYqIFH4B8SLLljHGYAzzGMLY4VV0Cxa/ihC9PpfRF8VSjYlCoRf/wiwZj3yNyzzGELbLBXDH/EHAboeSN00wTZk52u+Dn69nhjxFtF18AQcfgeZHr8WzqsDXgkJ4CyOQcJLE6DZ4mp3ZwtLlRHUT7iCr4s66Kdt7MSw/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TCIbV5o+; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-78f9b964c3eso9242717b3.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200538; x=1768805338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5BtvNEFgqWL2yj8vB56uvRZyhnBjlOJonajbEim00g=;
        b=E2Wjw+EKrIlfQ9mfYKLWgQrdWqE8ufKLn0SK6kDKhj3vvENGXWPpN+3BkHEEOhWlFz
         57mAJjXc0OmtXfaD1jCmy+lPHOZ7lOeuICiuhT3eghKb5VJx0xN8U4aER1sZ7Trb8Bbt
         WYnyGnIUCKAO31ytkPCLw5FQEzKaH6GV+8wj+Nk4ItxhPRqumh9YIEZ7o3/cU2qRtNHE
         F15yiwGuLNgg/xDllCaTZHwvUlIW4O40N9axpzEc00whUy4hXvultYT82SKjaalZRcTz
         A/vkf+WREELlzpFexQsLu3C44ohao1cinWDp7N7JxWEzUeFQOfX5MpXX/+DNVTleTal+
         gQYg==
X-Forwarded-Encrypted: i=1; AJvYcCUJgs0B/13DYdafSNRyNK5YlSrG1gHZDXImEmv0DHP/M2p5dIGtRl0d6bUIJ13DTB761eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5NcMFzZFg0pEXYc6tXgwDDMTev86oc3TormjkzxeItLqARt1
	hk/q9xBqgnI9NrzVc/JS1bho6KPIvfbihQ6jPhJpn9HR8gddJ6CX4uMI7uiXUBaVC6txVfvw84/
	My6r69dWR/qRhYa8ufjNaeFadwdkZ0arDUy+d+m8I6AJ+SypxFZ2mGwbeYiqAq+2iKYLr4T+f75
	vVweRCsAmEA/Yu/+2vJ9leJjEQzVz0bNq5KZ5C8WG80sX0NtqjJmiRKZyeKUsWPPhE/o6PGHUDS
	PqJT+Jbkme8IS/W3ZDlRDcYJSY=
X-Gm-Gg: AY/fxX5miUa7rua0dZxL7L+j5N699DqtN0iKxv+HVXk5qXVtBidbI5sT2uU5X1e4DBl
	5IU5lt+a2tZ91YlOD/lDQ18jR0xE6wiE/wflYgOvxafcHdAp/wGvuKW4Q80R0CajmS3UQk7dXO7
	4ci5LNY9dbOLuXVxmfTRxfg+qOCe21X/OuwRxoecdpT3RhQe3tjHqc1l/TXbgF4IGr1RuqAgw1o
	N2EZjjGOKxKgieBEgMOPNQ2WuApzlmruiNXAuh86fjvXfj7fAqMqOH83WMxa5k6FWAnPrfUgPuY
	ENWnQpUFss3AF52uzgrY2D3jBScVfhMet82cB2OnujGMd2+OwPlyu+4/rV4UnU3NAAP6Q+Boycb
	GMlOyZD5uOprZsQqkrMbQxrTtQUDvekwdDcT5jlZhQ8jSzT81dlSAHrzjTF2HkETAr+JYumeZ7B
	XE5QsT5JHKH/OsKX+GAb1sOnhwtAWmvSfDI9jdoIff/PJinq+2WyG8khhd0+o=
X-Google-Smtp-Source: AGHT+IGAChulE0jMq/nku3y3MWdIyxEnpQzMGhXhMk22NTdDs2LihvSTGImTQaazmwDsqhHBI3h0jSbMYZsx
X-Received: by 2002:a05:690c:60c7:b0:787:c607:5e35 with SMTP id 00721157ae682-790b55c0628mr134171847b3.1.1768200538524;
        Sun, 11 Jan 2026 22:48:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa433287sm13144207b3.0.2026.01.11.22.48.58
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:48:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edaa289e0dso20367491cf.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200537; x=1768805337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5BtvNEFgqWL2yj8vB56uvRZyhnBjlOJonajbEim00g=;
        b=TCIbV5o+ui8Szxs3PaHx240JMR8a6FA4i4yPwhh3UnxJsbVpiRelieF125D9PW+zqL
         OlhUsMv2SloUdfVuXD4ycE3rFGrjkIGLIQ0rL12+dH/Z6puFPEegSiw3bLvI8oy9k7Lb
         fy63YGyzk/gjyRzM4mzRH7zgsYsFp9Em+Cq00=
X-Forwarded-Encrypted: i=1; AJvYcCXBsoNo/da3GOutx54iQ+GNjiSPLfg2XJ4vWlQ/+pDUsVNdw+f/yPLKYGvx7UBZemEAr8Q=@vger.kernel.org
X-Received: by 2002:ac8:57d5:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-4ffb4861697mr202473821cf.4.1768200537483;
        Sun, 11 Jan 2026 22:48:57 -0800 (PST)
X-Received: by 2002:ac8:57d5:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-4ffb4861697mr202473711cf.4.1768200537162;
        Sun, 11 Jan 2026 22:48:57 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm131125426d6.23.2026.01.11.22.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:48:56 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v6.6.y 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:45:52 +0000
Message-ID: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 17 ++++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.43.7


