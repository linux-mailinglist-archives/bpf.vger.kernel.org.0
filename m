Return-Path: <bpf+bounces-69496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0CB97DD0
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 02:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56423A7517
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA418C034;
	Wed, 24 Sep 2025 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="ibTt4DZe"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5123AD
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673403; cv=pass; b=ffESyWNSNjP9cUxdJfKRMtGW/y7hloKZyv3zocidr8TR9whGt4lnwsi8ZTE+4TiOMtcqoslGP6/e/COjSgGDhKPPg7tOmGJ1G+62Z5R8Omo5wFwvpjMvzDTg1j7ELuAU4lHkoNO+9gjR3LKV+rrmrzH2hhH3kdINVR5dVtP/fj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673403; c=relaxed/simple;
	bh=ZCsliBvIdIXXOGAPXfXMIog/3EYo19FXNnI7SZRPJ4k=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=uT8B2vqwAAoueg0UbZ7PtJzhobMHIssmFChw0pUdBqUEsTEjVL0UCqeXmZKX3lA6jmxr43ZQZtM/XhexL0bUGboKzl6Bjfx8HfAX5wcD2/5tlyyYQf5MuBNhx0qKjPPYfepw20rKk7YrkqPzo23OaUIVBRgiv3mkyEjDSiJ9YGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=ibTt4DZe; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758673401; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=SIhtLy0Bz0jPql7IejxwCg9p4H+8piucB6ClH5DMfESZsWU7LZGAkYqUqDPbce3+q5sCZhrjfJ88xreYA9JvSSqRkAYI6o9EVYxK3syx4VxtpBjxeyT2z9ZIdg7US9WctwO2S/lixgq7cL2pJGwS8pXJNrnfKK8yCGTiRPM8bJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758673401; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=ZCsliBvIdIXXOGAPXfXMIog/3EYo19FXNnI7SZRPJ4k=; 
	b=W/SQmc1uPS1hsi/4CfXCwIWazCZkIQYvBSKAeT+FI3eW3BP78lpQ6H5sk11S9nFbHOvBrmTH8iJOoTSPrZ4v2DnbDOmCSxLbB78XwLHS9OiooZaB2koOfq7VDB4ZuR9hOZsBDw1tqvkcPeN/uEHi+Qk7ZbQR6fnaJcywCHr0Ntg=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+067f4500-98d7-11f0-8217-5254007ea3ec_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758670974877863.9976184607308;
	Tue, 23 Sep 2025 16:42:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=ibTt4DZeXhAxicQU2F5ixqWobq1rDWhQ44tlVrwNJ65ONA7ApYYlGEl+8NAVh1b/5Zxmhu8hsvCa/4YIktaFd8s7a8nVGhPV3itD0w0GsMCpDsRYv2vv3lp9UvnXKg6azgpvOjSNPeAY95sRLGHuHqwh5WkZ2+zzVtTsygbG9HA=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=ZCsliBvIdIXXOGAPXfXMIog/3EYo19FXNnI7SZRPJ4k=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:42:54 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: bpf@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.067f4500-98d7-11f0-8217-5254007ea3ec.19978f56d50@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.067f4500-98d7-11f0-8217-5254007ea3ec.19978f56d50
X-JID: 2d6f.1aedd99b146bc1ac.s1.067f4500-98d7-11f0-8217-5254007ea3ec.19978f56d50
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.067f4500-98d7-11f0-8217-5254007ea3ec.19978f56d50
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.067f4500-98d7-11f0-8217-5254007ea3ec.19978f56d50
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.067f4500-98d7-11f0-8217-5254007ea3ec.19978f56d50@zeptomail.com>
X-ZohoMailClient: External

To: bpf@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

