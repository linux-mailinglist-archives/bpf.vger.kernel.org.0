Return-Path: <bpf+bounces-37367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6319954AEB
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9386F2846DE
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6901BB6A5;
	Fri, 16 Aug 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b="s60ofRk7"
X-Original-To: bpf@vger.kernel.org
Received: from mail.hotelshavens.com (mail.hotelshavens.com [217.156.64.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420C1B9B46
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.156.64.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814472; cv=none; b=ed/ln5CIdzKXpRF3ZhFHjr7suACDxrLLCZftjA7q/4EqrWADacUMVzeYbatBoF8Pzat7r0GgVMs+zlvafCb8v6i1rGtoBec/N4G4XASZ1Y1IMAM5wdmjw/eylGaB31nMA+EC7mA1KMw2+/uJTJTlxTa7iIFb/hCYW8BTwIbhupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814472; c=relaxed/simple;
	bh=le8D/DGAAac0mTvut3fZ23mHyfKOVUcsbcfNgehFJsw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lizQlrUeri2qRmx1dRSt15FDc14q2fCjunCKaAA8eueoIicwOXlBBZKRKfWbptZP34SwnCw9KnZ024INJWj8hX8GsEQuPkQvrMRJg81BfkPJTRzYWGVZG4QuxDr/M80zIxqUJq1WGFgmeh2lCQBr3/t+5Ys8DwVHF7xtuJxDWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com; spf=pass smtp.mailfrom=hotelshavens.com; dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b=s60ofRk7; arc=none smtp.client-ip=217.156.64.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotelshavens.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=hotelshavens.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@hotelshavens.com;
 bh=le8D/DGAAac0mTvut3fZ23mHyfKOVUcsbcfNgehFJsw=;
 b=s60ofRk7av+wE3ouHfbcRFdTL1mVRIhQckAC5/R2iJTHDBf8TkxLCzC7MVBCiFBE3n8ISI9QQeE2
   bmScHGXxdKVr8EIOCs/3lEk6tiJEz/xKaq2n9xOx8dvi2aN5j2KnRZz1QmYM+DkimPDZpae8nnJ+
   HhlaE+2+06ax1Fr5sKBsuVw4Uptq0n7P6su7IgcOvvXkJHxKWMG5WaVt2Z5K9oi6+8wYMq3JWWxj
   fZuKTGPxGyfVT14lueMTr+RuPN4oO3LscXAnHJGRd3fW2ZXQj0o6RBuW0Ju0q+aAarAhgSDg6VrP
   +43h6CXw8SKlWsNL59C/8JpmgmnvsUfzsxIBOkrslXMWRCwm5Td5UeMMK8W8223UaAwTznVoN97i
   BwppSEpa/jCJ4hV7Shct0xaBaYhOII3I//WCzkGy3mW5JH5SjxmYhW1XTTDKIPyyXWnZSUf0OCp/
   I/6jBuB7NaI5R3UYwF1CZ+q5uvM4d2sgDRWxcZ7rORKFZb1Lf5SdmjSlzousiLaGtt0T3keObvq3
   cNkXDLWcRUu4vz2S+l6MWkFfnCKjTuGQlqXi6ytkDsBHNHBXYhNPhDiVKDaLGgVmRdnxJCo+TaZw
   RGFiIAp59GC+kmwPHqo6iSnwfAlrW8CdV+g7lBFZZDXcgaPaaByugud6lOztgdPVHXtlUeqdScU=
Reply-To: boris@undpkh.com
From: Boris Soroka <admin@hotelshavens.com>
To: bpf@vger.kernel.org
Subject: HI DEAR !
Date: 16 Aug 2024 15:16:03 +0200
Message-ID: <20240816134828.F1B22E328FB874AE@hotelshavens.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

Did you receive my last email message I sent to this Email=20
address: ( bpf@vger.kernel.org ) concerning relocating my=20
investment to your country due to the on going war in my country=20
Russia.

Best Regards,
Mr.Boris Soroka.

