Return-Path: <bpf+bounces-53657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A6A57F60
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 23:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A33B0ADA
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 22:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89020DD5B;
	Sat,  8 Mar 2025 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhdLuWXB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166619006F;
	Sat,  8 Mar 2025 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741473704; cv=none; b=Wn0or8Bs9KPmt3jRAnd+eqx1q4YW7riKCXRrN+DNFTWzDSX5Vxq1orS1uHLKkWiikvXHlTKambi+FAx9g7mlT3bCuhC/dpXKyn1cMzIz/PCdniMAC+Kez7dkjS7r0tVypNW5kVz/H3HLug5rLIyogc55R+iyERdpJ5Mz2Egcyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741473704; c=relaxed/simple;
	bh=C4zE+73EWQ8ZVsBGoZlf+StXl3O+tyzUriwyrFbOKa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nas7kcW/cqRy+r2rczJygsK2qYWWsy5auHTEVNUAqEXbflCkya/uPhAodWFp7OciTBboJvblKEPVHsnSaFe6t0vMILM94n/sn8kwFB6yTXEiEAiGVzHPQnjGA67f6O+U1TKcWUjXz/ERDN6tMkcbLHRjhfj3VKHBoLX+cCaO7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhdLuWXB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224341bbc1dso25425505ad.3;
        Sat, 08 Mar 2025 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741473702; x=1742078502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fPMyxNmgolKEIW1uMpQno8oVVMoFLSw0UC+1Zt/nxE=;
        b=bhdLuWXBBNWqzmdRbkNTA7gWGxNq5zx6XJoDPeqqHYPKW/+y8PGEwS3/AXP8ZTHi80
         rgMZiM0GGPZpN72hnXRAPVEuQYLhPJo30oqd132b5z5z9lfw+8fSNYyOazOYWKXdprS/
         +mO3priv26S1uAbZebMUJkLPKAjKiFSg0+Lr4sVaPpnlir3KNXa0kNAZnclF/GdOFPeH
         QLG+fznwxv9XQCEf8bc+o6N3Pn+STsF85wAFsqzAelAeOT+BELMtlzV3GcjEXCCOfBTT
         ojSIwf8ercOwj1uZYsTZhjg+EdYH9AO4dRayr5rpfFdoz2DQBWQKiZgh5KsnUbNWHdEd
         wMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741473702; x=1742078502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fPMyxNmgolKEIW1uMpQno8oVVMoFLSw0UC+1Zt/nxE=;
        b=okQo2v9HHf/k2GpcSgw6tLoB3MdGtPtQ+5PsxK9ngdAKuxKdv8NX9BvaZ+VTT/WPk2
         wUmCGRT7IAMVIUUMkbJwljV/EYTM5EBtDIf3ks22nWcK8g0dpP6CorP7PLGuXzsyMvx5
         /t34pAAZ/q2QcvbwLSer4u3jRaRRL968zV2WsWTZBjNnz14vzEHLYOa911YF9BS7wEtJ
         gAzt+9f3iFkbUTSZWJ3kB943GN/LGxinQyuSzeDXqW4MO5o2udg/++wTl+M0eFEffWcZ
         JM3jIQtrxLeTWESJXd3WlxzjrWT33zkf1bx7o7sEj3ghYgkNjOUC+z3ronEEUKhgNQUZ
         +IWw==
X-Forwarded-Encrypted: i=1; AJvYcCUM+9EYCSmKNpFXsygf7a0aXvhKvV53FSVuLGNVWo6sre1qKv0wa/WAkgpVvb0vLrpQcnU=@vger.kernel.org, AJvYcCWyv2mfSIpxyWLlcVfcLTrIMBRNcDAExjnRz9nD8jb9oanS2IdatLHOQbo18cz6hd+crchAYqe2slmPKT1V@vger.kernel.org, AJvYcCXpKltbP84J0IYvBIrP31ytOT23ymHOt3GnxMEpshzCK0cn14wqM2NKTGDOeWAgYYq3YLE75tQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIRtB/EyA0dA0aF+z5Wa4NEvtSQ8jRdcFfQwDqaSoAXlz+Qc7
	/ivmmNmPLtkEqhlpUgsta1J3TEh8oioOGtCv3qk8oiaSTr5rN+E=
X-Gm-Gg: ASbGncv0+VeatS2H4/KswHe3lIgc9GfEiMei4K49gmENrp3iRAiYc+sZA9XtCrJOU84
	55bkcVEMuetZCKAJTA2CqUjEKSi4fj8ezBkUb6oHlBgNAxop9qchwCVGvs9HfkZVCqggulM+39F
	DxSfzas12FrSv326yaNroDP4XwaOOXpdoJL1dZKt8lf5KKXoeeM/1FZ05pabHGjgyQHUfcwTRu1
	WfClnUtLb0YC+/DLwhuW/Q0z/EKQuAMCAF8hmALwYJgfzUzPBGzsDBa1xmofSpuZYEToT+4w4jS
	27fyQf+3TITwSwFde2yWCEegtwd5MHIZcR0Uwq7cyPE+
X-Google-Smtp-Source: AGHT+IGF5zrLsdlkXnrbncS3XKunf2BikQsRsdSN1uU1BRL2NuN4OnXNdf4rFzbUe95e+zSgIBIzAw==
X-Received: by 2002:a17:902:da81:b0:224:c46:d167 with SMTP id d9443c01a7336-22428887604mr110358155ad.16.1741473702411;
        Sat, 08 Mar 2025 14:41:42 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109de155sm51695545ad.27.2025.03.08.14.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 14:41:41 -0800 (PST)
Date: Sat, 8 Mar 2025 14:41:41 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kohei Enju <kohei.enju@gmail.com>
Subject: Re: [PATCH net-next v1] dev: remove netdev_lock() and
 netdev_lock_ops() in register_netdevice().
Message-ID: <Z8zHpf6JPfjkC_Sv@mini-arch>
References: <20250308203835.60633-2-enjuk@amazon.com>
 <20250308131813.4f8c8f0d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308131813.4f8c8f0d@kernel.org>

On 03/08, Jakub Kicinski wrote:
> On Sun, 9 Mar 2025 05:37:18 +0900 Kohei Enju wrote:
> > Both netdev_lock() and netdev_lock_ops() are called before
> > list_netdevice() in register_netdevice().
> > No other context can access the struct net_device, so we don't need these
> > locks in this context.

That's technically true, but it will set off a bunch of lockdep
warnings :-(

> Doesn't sysfs get registered earlier?
> I'm afraid not being able to take the lock from the registration
> path ties our hands too much. Maybe we need to make a more serious
> attempt at letting the caller take the lock?

This looks like another case of upper/lower :-( So maybe we need to solve
it for real? With an extra upper_lock pointer in the netdev?
Untested patch to convey the general idea:

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3c549f73909..9c85179431e6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2520,6 +2520,7 @@ struct net_device {
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
+	struct mutex		*upper_lock;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	/**
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 90597bf84e3d..3d0fda6e9bca 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3022,6 +3022,9 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	char ifname[IFNAMSIZ];
 	int err;
 
+	/* TODO: add another wrapper for this */
+	if (dev->upper_lock)
+		mutex_lock(dev->upper_lock);
 	netdev_lock_ops(dev);
 
 	err = validate_linkmsg(dev, tb, extack);
@@ -3394,6 +3397,8 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	}
 
 	netdev_unlock_ops(dev);
+	if (dev->upper_lock)
+		mutex_unlock(dev->upper_lock);
 
 	return err;
 }
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b0423046028c..818ff487b363 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -304,7 +304,7 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	if (!dev->ieee80211_ptr->registered)
 		return 0;
 
-	guard(wiphy)(local->hw.wiphy);
+	/* TODO: remove guard from other places */
 
 	return _ieee80211_change_mac(sdata, addr);
 }
@@ -2227,6 +2227,8 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 			free_netdev(ndev);
 			return ret;
 		}
+
+		ndev->upper_lock = &local->hw.wiphy.mtx;
 	}
 
 	mutex_lock(&local->iflist_mtx);


