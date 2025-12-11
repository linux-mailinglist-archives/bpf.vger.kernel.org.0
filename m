Return-Path: <bpf+bounces-76448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA7CB487B
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D443036C8C
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B412D1905;
	Thu, 11 Dec 2025 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mGmASbiz"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9112BF3CA;
	Thu, 11 Dec 2025 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419192; cv=none; b=JbjWzVTtwO/swDRo6MChFDSnLwr/tSSwDmsjqKAeixBzOOL9cPOUOcb1Fcv+2u5/r6btaHaM98kHRjPFw3G6oLKtIUsysLxvvNKwVqrEUp5IvHd89Qg8Ah8PUBJumCN4qJCF/fzcni2rnrV7523Uo9jXLn6rjxtxCGWVmZNGHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419192; c=relaxed/simple;
	bh=Dqc8agm8gURJma6ClOZJYRfjbrKP4jFtpJg3r3rg1jc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfLy9aMLrUtVT1XSx83uPbG5InxjI3TOjd2+EScrtnfXy6WiGWZnDATyo7vOcSytCA3M9waxUOXWFACw1Y95x2fL+l077yDLjNtkM7hA8bYNABp0BkOmJb+kOB9X7F4/h48C/GVykNzBMb0Uafj/KNixGTQl/P1Qov9Zkt4yWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mGmASbiz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C9752116049;
	Wed, 10 Dec 2025 18:13:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C9752116049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419189;
	bh=sGawIizX9EcFfZvX74eliwpwV9cGLLP4TSAKVsWNDnQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mGmASbizNb3JewyGTx+YCgfhaCkgTnrt7aqqU5tlQUMMEUT0zXd0+OzGiI/ds0meX
	 eGnGnUdk2zN2eDfHdfiExvIzOqMKFQ/IB68StwTqTyXxNCyu20YAvTsGePrWYVZlty
	 BQGD30ZLGc2HDSblOjqpZzN2EeYjnhFGULUfpMjc=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC 02/11] oid_registry: allow arbitrary size OIDs
Date: Wed, 10 Dec 2025 18:11:57 -0800
Message-ID: <20251211021257.1208712-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

The current OID registry parser uses 64 bit arithmetic which limits us
to supporting 64 bit or smaller OIDs.  This isn't usually a problem
except that it prevents us from representing the 2.25. prefix OIDs
which are the OID representation of UUIDs and have a 128 bit number
following the prefix.  Rather than import not often used perl
arithmetic modules, replace the current perl 64 bit arithmetic with a
callout to bc, which is arbitrary precision, for decimal to base 2
conversion, then do pure string operations on the base 2 number.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 lib/build_OID_registry | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/lib/build_OID_registry b/lib/build_OID_registry
index 8267e8d71338b..30493ac190c0c 100755
--- a/lib/build_OID_registry
+++ b/lib/build_OID_registry
@@ -60,10 +60,12 @@ for (my $i = 0; $i <= $#names; $i++) {
     # Determine the encoded length of this OID
     my $size = $#components;
     for (my $loop = 2; $loop <= $#components; $loop++) {
-	my $c = $components[$loop];
+	$ENV{'BC_LINE_LENGTH'} = "0";
+	my $c = `echo "ibase=10; obase=2; $components[$loop]" | bc`;
+	chomp($c);
 
 	# We will base128 encode the number
-	my $tmp = ($c == 0) ? 0 : int(log($c)/log(2));
+	my $tmp = length($c) - 1;
 	$tmp = int($tmp / 7);
 	$size += $tmp;
     }
@@ -100,16 +102,24 @@ for (my $i = 0; $i <= $#names; $i++) {
     push @octets, $components[0] * 40 + $components[1];
 
     for (my $loop = 2; $loop <= $#components; $loop++) {
-	my $c = $components[$loop];
+	# get the base 2 representation of the component
+	$ENV{'BC_LINE_LENGTH'} = "0";
+	my $c = `echo "ibase=10; obase=2; $components[$loop]" | bc`;
+	chomp($c);
 
-	# Base128 encode the number
-	my $tmp = ($c == 0) ? 0 : int(log($c)/log(2));
+	my $tmp = length($c) - 1;
 	$tmp = int($tmp / 7);
 
-	for (; $tmp > 0; $tmp--) {
-	    push @octets, (($c >> $tmp * 7) & 0x7f) | 0x80;
+	# zero pad upto length multiple of 7
+	$c = substr("0000000", 0, ($tmp + 1) * 7 - length($c)).$c;
+
+	# Base128 encode the number
+	for (my $j = 0; $j < $tmp; $j++) {
+	    my $b = oct("0b".substr($c, $j * 7, 7));
+
+	    push @octets, $b | 0x80;
 	}
-	push @octets, $c & 0x7f;
+	push @octets, oct("0b".substr($c, $tmp * 7, 7));
     }
 
     push @encoded_oids, \@octets;
-- 
2.52.0


