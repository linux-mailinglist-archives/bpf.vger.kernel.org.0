Return-Path: <bpf+bounces-47163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B89F5C4D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27974160C25
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693F35965;
	Wed, 18 Dec 2024 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KzH1VV/m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6730FC0E;
	Wed, 18 Dec 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485792; cv=none; b=HavO5mFMVCAXsQMCzIhoyOA+SPolItfFYW977GVWRdbAfxhs/zON7jVXvqJNL84TebatDgP42u66Ef9Iipv/boEloVHh7q0bu0MeLiYkFtqQCe0aJkGWCOQgVNULLGtpaD5ObjhqiP2rrZNAyJbbhBAP6S3HnXzfIzyU+xrYn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485792; c=relaxed/simple;
	bh=jGNDHyv62lsFaBFKLyZME1rN5u58tCsBfMgJCyMMx00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO+fSfVXCzkCsCS/5AVdXfgLZ0sjTO8y/yMxrpG/sFtF3Jr6KYrGWAFc6QOu1zZuErdQNOobZrPllhOcqynixuTEKTiFYnNevADfAARNRa0g2d6Y0AEPi1sGOW2Vv3t/tpCejVjta9auhfQ5wibWrGVzoVVUTaoJvnndBdHS/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KzH1VV/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38411C4CED3;
	Wed, 18 Dec 2024 01:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734485792;
	bh=jGNDHyv62lsFaBFKLyZME1rN5u58tCsBfMgJCyMMx00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzH1VV/mQeuvyluKEhny9tDURboyFQfnvxv2kwLvag8NzM1pmcknnITonp8VUaxz3
	 dYtrUzDXyzA6rj7Q53/04NALI4cEP3lAt4gmFh/7E3lVx0xKaogLRKanl8JV12DnPO
	 62a4U5PXYFByhyis1HncqPzH6GpPGpDtQ9xKKQhg=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Florent Revest <revest@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] vsprintf: simplify number handling
Date: Tue, 17 Dec 2024 17:32:09 -0800
Message-ID: <20241218013620.1679088-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.47.1.402.g41f6bc43b7
In-Reply-To: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
References: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of dealing with all the different special types (size_t,
unsigned char, ptrdiff_t..) just deal with the size of the integer type
and the sign.

This avoids a lot of unnecessary case statements, and the games we play
with the value of the 'SIGN' flags value

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

NOTE! Only very lightly tested.  Also meant to be purely preparatory. 
It might be broken. 

I started doing this in the hope that the vsnprintf() core code could
maybe be further cleaned up enough that it would actually be something
we could use more generally and export to other users that want to
basically do the printk format handling. 

The code is *not* there yet, though. Small steps.

 lib/vsprintf.c | 139 +++++++++++++------------------------------------
 1 file changed, 37 insertions(+), 102 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9d3dac38a3f4..ad57b43bb9ab 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -407,7 +407,7 @@ int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
 	return len + width;
 }
 
-#define SIGN	1		/* unsigned/signed, must be 1 */
+#define SIGN	1		/* unsigned/signed */
 #define LEFT	2		/* left justified */
 #define PLUS	4		/* show plus */
 #define SPACE	8		/* space if plus */
@@ -415,12 +415,15 @@ int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
 #define SMALL	32		/* use lowercase in hex (must be 32 == 0x20) */
 #define SPECIAL	64		/* prefix hex with "0x", octal with "0" */
 
-static_assert(SIGN == 1);
 static_assert(ZEROPAD == ('0' - ' '));
 static_assert(SMALL == ('a' ^ 'A'));
 
 enum format_type {
 	FORMAT_TYPE_NONE, /* Just a string part */
+	FORMAT_TYPE_1BYTE = 1, /* char/short/int are their own sizes */
+	FORMAT_TYPE_2BYTE = 2,
+	FORMAT_TYPE_8BYTE = 3,
+	FORMAT_TYPE_4BYTE = 4,
 	FORMAT_TYPE_WIDTH,
 	FORMAT_TYPE_PRECISION,
 	FORMAT_TYPE_CHAR,
@@ -428,19 +431,10 @@ enum format_type {
 	FORMAT_TYPE_PTR,
 	FORMAT_TYPE_PERCENT_CHAR,
 	FORMAT_TYPE_INVALID,
-	FORMAT_TYPE_LONG_LONG,
-	FORMAT_TYPE_ULONG,
-	FORMAT_TYPE_LONG,
-	FORMAT_TYPE_UBYTE,
-	FORMAT_TYPE_BYTE,
-	FORMAT_TYPE_USHORT,
-	FORMAT_TYPE_SHORT,
-	FORMAT_TYPE_UINT,
-	FORMAT_TYPE_INT,
-	FORMAT_TYPE_SIZE_T,
-	FORMAT_TYPE_PTRDIFF
 };
 
+#define FORMAT_TYPE_SIZE(type) (sizeof(type) <= 4 ? sizeof(type) : FORMAT_TYPE_8BYTE)
+
 struct printf_spec {
 	unsigned int	type:8;		/* format_type enum */
 	signed int	field_width:24;	/* width of output field */
@@ -2707,23 +2701,19 @@ int format_decode(const char *fmt, struct printf_spec *spec)
 	}
 
 	if (qualifier == 'L')
-		spec->type = FORMAT_TYPE_LONG_LONG;
+		spec->type = FORMAT_TYPE_SIZE(long long);
 	else if (qualifier == 'l') {
-		BUILD_BUG_ON(FORMAT_TYPE_ULONG + SIGN != FORMAT_TYPE_LONG);
-		spec->type = FORMAT_TYPE_ULONG + (spec->flags & SIGN);
+		spec->type = FORMAT_TYPE_SIZE(long);
 	} else if (qualifier == 'z') {
-		spec->type = FORMAT_TYPE_SIZE_T;
+		spec->type = FORMAT_TYPE_SIZE(size_t);
 	} else if (qualifier == 't') {
-		spec->type = FORMAT_TYPE_PTRDIFF;
+		spec->type = FORMAT_TYPE_SIZE(ptrdiff_t);
 	} else if (qualifier == 'H') {
-		BUILD_BUG_ON(FORMAT_TYPE_UBYTE + SIGN != FORMAT_TYPE_BYTE);
-		spec->type = FORMAT_TYPE_UBYTE + (spec->flags & SIGN);
+		spec->type = FORMAT_TYPE_SIZE(char);
 	} else if (qualifier == 'h') {
-		BUILD_BUG_ON(FORMAT_TYPE_USHORT + SIGN != FORMAT_TYPE_SHORT);
-		spec->type = FORMAT_TYPE_USHORT + (spec->flags & SIGN);
+		spec->type = FORMAT_TYPE_SIZE(short);
 	} else {
-		BUILD_BUG_ON(FORMAT_TYPE_UINT + SIGN != FORMAT_TYPE_INT);
-		spec->type = FORMAT_TYPE_UINT + (spec->flags & SIGN);
+		spec->type = FORMAT_TYPE_SIZE(int);
 	}
 
 	return ++fmt - start;
@@ -2747,6 +2737,17 @@ set_precision(struct printf_spec *spec, int prec)
 	}
 }
 
+/* Turn a 1/2/4-byte value into a 64-bit one with sign handling */
+static unsigned long long get_num(unsigned int val, struct printf_spec spec)
+{
+	unsigned int shift = 32 - spec.type*8;
+
+	val <<= shift;
+	if (!(spec.flags & SIGN))
+		return val >> shift;
+	return (int)val >> shift;
+}
+
 /**
  * vsnprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2873,43 +2874,10 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 			goto out;
 
 		default:
-			switch (spec.type) {
-			case FORMAT_TYPE_LONG_LONG:
+			if (spec.type == FORMAT_TYPE_8BYTE)
 				num = va_arg(args, long long);
-				break;
-			case FORMAT_TYPE_ULONG:
-				num = va_arg(args, unsigned long);
-				break;
-			case FORMAT_TYPE_LONG:
-				num = va_arg(args, long);
-				break;
-			case FORMAT_TYPE_SIZE_T:
-				if (spec.flags & SIGN)
-					num = va_arg(args, ssize_t);
-				else
-					num = va_arg(args, size_t);
-				break;
-			case FORMAT_TYPE_PTRDIFF:
-				num = va_arg(args, ptrdiff_t);
-				break;
-			case FORMAT_TYPE_UBYTE:
-				num = (unsigned char) va_arg(args, int);
-				break;
-			case FORMAT_TYPE_BYTE:
-				num = (signed char) va_arg(args, int);
-				break;
-			case FORMAT_TYPE_USHORT:
-				num = (unsigned short) va_arg(args, int);
-				break;
-			case FORMAT_TYPE_SHORT:
-				num = (short) va_arg(args, int);
-				break;
-			case FORMAT_TYPE_INT:
-				num = (int) va_arg(args, int);
-				break;
-			default:
-				num = va_arg(args, unsigned int);
-			}
+			else
+				num = get_num(va_arg(args, int), spec);
 
 			str = number(str, end, num, spec);
 		}
@@ -3183,26 +3151,13 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 
 		default:
 			switch (spec.type) {
-
-			case FORMAT_TYPE_LONG_LONG:
+			case FORMAT_TYPE_8BYTE:
 				save_arg(long long);
 				break;
-			case FORMAT_TYPE_ULONG:
-			case FORMAT_TYPE_LONG:
-				save_arg(unsigned long);
-				break;
-			case FORMAT_TYPE_SIZE_T:
-				save_arg(size_t);
-				break;
-			case FORMAT_TYPE_PTRDIFF:
-				save_arg(ptrdiff_t);
-				break;
-			case FORMAT_TYPE_UBYTE:
-			case FORMAT_TYPE_BYTE:
+			case FORMAT_TYPE_1BYTE:
 				save_arg(char);
 				break;
-			case FORMAT_TYPE_USHORT:
-			case FORMAT_TYPE_SHORT:
+			case FORMAT_TYPE_2BYTE:
 				save_arg(short);
 				break;
 			default:
@@ -3375,37 +3330,17 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			unsigned long long num;
 
 			switch (spec.type) {
-
-			case FORMAT_TYPE_LONG_LONG:
+			case FORMAT_TYPE_8BYTE:
 				num = get_arg(long long);
 				break;
-			case FORMAT_TYPE_ULONG:
-			case FORMAT_TYPE_LONG:
-				num = get_arg(unsigned long);
+			case FORMAT_TYPE_2BYTE:
+				num = get_num(get_arg(short), spec);
 				break;
-			case FORMAT_TYPE_SIZE_T:
-				num = get_arg(size_t);
-				break;
-			case FORMAT_TYPE_PTRDIFF:
-				num = get_arg(ptrdiff_t);
-				break;
-			case FORMAT_TYPE_UBYTE:
-				num = get_arg(unsigned char);
-				break;
-			case FORMAT_TYPE_BYTE:
-				num = get_arg(signed char);
-				break;
-			case FORMAT_TYPE_USHORT:
-				num = get_arg(unsigned short);
-				break;
-			case FORMAT_TYPE_SHORT:
-				num = get_arg(short);
-				break;
-			case FORMAT_TYPE_UINT:
-				num = get_arg(unsigned int);
+			case FORMAT_TYPE_1BYTE:
+				num = get_num(get_arg(char), spec);
 				break;
 			default:
-				num = get_arg(int);
+				num = get_num(get_arg(int), spec);
 			}
 
 			str = number(str, end, num, spec);
-- 
2.47.1.402.g41f6bc43b7


