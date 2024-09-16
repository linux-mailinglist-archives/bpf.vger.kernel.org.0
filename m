Return-Path: <bpf+bounces-39988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F54979E3D
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8DA2812CD
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59C1494DF;
	Mon, 16 Sep 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeHtyvnK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29661422B8
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478300; cv=none; b=Ae5+C85zaELKnwaW65jCQFbv/p/O1jD6697cNi/vTYEg/EVIU7rB2xTwR1uZNt1PhAc+4tZxNZl7j3hoayFqSKHv2+M3ltulhhwAcUUDQszINv1a66yBrBFg8Wb3L0Cua2nB+LITrgwz+0MQjSC18QZNs3nGEloKxugsKJfQl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478300; c=relaxed/simple;
	bh=Ehu+tQlV3Yn9+mb+64Att64L+pNpYJzRbY/H/0fZsUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE5RKDph2K0e/Ox+X+qdMQB8nXCWkjSpmBRd7CuzTUn4PGVwh8Iem5JFUrrBLXarXDtVz1YQbcKZHT2rdhNdJNmPEcDHscXzdtjegIjcBtxPRmntw3dl4UwmHVhi1+eueDUNNAzdvPcPikD3YmHe/4VITIfwo2lXthLARVrelwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeHtyvnK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2068acc8a4fso26828015ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478298; x=1727083098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tLwns4BgiXw9pLV109Ngds60h7ORpQpM9oAr5JWGfY=;
        b=KeHtyvnK7GUUjooDXXpi45neQo3uUdehKsuCxqDlLqiFcQ1iBG87qJ4x6e+u4QqIPq
         EJEHeS82r19WllBgZCEu+NhWd8jjVXYYjxkyCbDAKfYbx1TnM6ELHEUkuf07SP5AKXav
         FeQVACkWyBmsxmjMU4lrNNutVXk2Yy6YgAp9Cn4KFJu4aBygtHryNjB7FhaIQuVSrrao
         vautG+fKerBLXgw+EKJ5pWfZa0ZMHyFEm5INxhAUMzgBwguBhdz4MDfqxqqfeU8Im6EB
         EHqbn+tIvtzSNzqIKAOWeQQHGZQsnq1J6B8LoMj5mKeitEObonu9UQNptPIOBkDnWIUS
         kytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478298; x=1727083098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tLwns4BgiXw9pLV109Ngds60h7ORpQpM9oAr5JWGfY=;
        b=h9iwnDrb8JTTKTtbq/uzp9uTbFxaSJaEGocOYua1RkSPTkf13CIXymYDjuVFtz5Ok7
         7K1moD5+LqvWTQ1INAPo0gMsJdyiYD9ragiWiwjonYg6thxcKQw8PVmNOHjFeHf1dIBA
         z5+SN3YtljTeNNglz7PvD/V1bukS2LJ861s/gVa4UUxlkMTky1M2gWQsat22Gv+xqm0W
         Oy9pfKrDo7FHf/2nT1Qnri4coubskQ/cfFGLU+BQvtZRJvLLKWbSQACqIyaN6rCn0X6A
         ZybpZ8jckNECiLDWGeTZzxi4zH+4AfA1t4HCIOeR1WhtLSGt4PgauFCUPhihjsZvLTwg
         y+/A==
X-Gm-Message-State: AOJu0YzZOqm9Iy0xUcxSkttAfkafbg/f0Ku0l5WQjyLc6tTQ1hrAeLUE
	++wfqGBjSZ9A3N52EN+WHXo7QwOdCth2BAMaKlhXTVjZpKroQUZ5YQ4oZw==
X-Google-Smtp-Source: AGHT+IGWJWQj0zMrq/Ra1kxCXRdntcPH5pneCWsuYBHFZIrfsJLC4sChWsVlDmdq6/B+9AcsmN9ErA==
X-Received: by 2002:a17:902:d2ca:b0:202:2f0:3bb2 with SMTP id d9443c01a7336-20782c201e0mr109652265ad.60.1726478297621;
        Mon, 16 Sep 2024 02:18:17 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da63fsm32882195ad.38.2024.09.16.02.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:18:16 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	arnaldo.melo@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/4] bpf: allow specifying bpf_fastcall attribute for BPF helpers
Date: Mon, 16 Sep 2024 02:17:09 -0700
Message-ID: <20240916091712.2929279-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916091712.2929279-1-eddyz87@gmail.com>
References: <20240916091712.2929279-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow a new optional 'Attributes' section to be specified for helper
functions description, e.g.:

 * u32 bpf_get_smp_processor_id(void)
 * 		...
 * 	Return
 * 		...
 * 	Attributes
 * 		__bpf_fastcall
 *

Generated header for the example above:

  #ifndef __bpf_fastcall
  #if __has_attribute(__bpf_fastcall)
  #define __bpf_fastcall __attribute__((bpf_fastcall))
  #else
  #define __bpf_fastcall
  #endif
  #endif
  ...
  __bpf_fastcall
  static __u32 (* const bpf_get_smp_processor_id)(void) = (void *) 8;

The following rules apply:
- when present, section must follow 'Return' section;
- attribute names are specified on the line following 'Attribute'
  keyword;
- attribute names are separated by spaces;
- section ends with an "empty" line (" *\n").

Valid attribute names are recorded in the ATTRS map.
ATTRS maps shortcut attribute name to correct C syntax.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 scripts/bpf_doc.py | 50 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index c55878bddfdd..db50c8d7d112 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -37,10 +37,11 @@ class APIElement(object):
     @desc: textual description of the symbol
     @ret: (optional) description of any associated return value
     """
-    def __init__(self, proto='', desc='', ret=''):
+    def __init__(self, proto='', desc='', ret='', attrs=[]):
         self.proto = proto
         self.desc = desc
         self.ret = ret
+        self.attrs = attrs
 
 
 class Helper(APIElement):
@@ -81,6 +82,11 @@ class Helper(APIElement):
         return res
 
 
+ATTRS = {
+    '__bpf_fastcall': 'bpf_fastcall'
+}
+
+
 class HeaderParser(object):
     """
     An object used to parse a file in order to extract the documentation of a
@@ -111,7 +117,8 @@ class HeaderParser(object):
         proto    = self.parse_proto()
         desc     = self.parse_desc(proto)
         ret      = self.parse_ret(proto)
-        return Helper(proto=proto, desc=desc, ret=ret)
+        attrs    = self.parse_attrs(proto)
+        return Helper(proto=proto, desc=desc, ret=ret, attrs=attrs)
 
     def parse_symbol(self):
         p = re.compile(r' \* ?(BPF\w+)$')
@@ -192,6 +199,28 @@ class HeaderParser(object):
             raise Exception("No return found for " + proto)
         return ret
 
+    def parse_attrs(self, proto):
+        p = re.compile(r' \* ?(?:\t| {5,8})Attributes$')
+        capture = p.match(self.line)
+        if not capture:
+            return []
+        # Expect a single line with mnemonics for attributes separated by spaces
+        self.line = self.reader.readline()
+        p = re.compile(r' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
+        capture = p.match(self.line)
+        if not capture:
+            raise Exception("Incomplete 'Attributes' section for " + proto)
+        attrs = capture.group(1).split(' ')
+        for attr in attrs:
+            if attr not in ATTRS:
+                raise Exception("Unexpected attribute '" + attr + "' specified for " + proto)
+        self.line = self.reader.readline()
+        if self.line != ' *\n':
+            raise Exception("Expecting empty line after 'Attributes' section for " + proto)
+        # Prepare a line for next self.parse_* to consume
+        self.line = self.reader.readline()
+        return attrs
+
     def seek_to(self, target, help_message, discard_lines = 1):
         self.reader.seek(0)
         offset = self.reader.read().find(target)
@@ -789,6 +818,21 @@ class PrinterHelpers(Printer):
             print('%s;' % fwd)
         print('')
 
+        used_attrs = set()
+        for helper in self.elements:
+            for attr in helper.attrs:
+                used_attrs.add(attr)
+        for attr in sorted(used_attrs):
+            print('#ifndef %s' % attr)
+            print('#if __has_attribute(%s)' % ATTRS[attr])
+            print('#define %s __attribute__((%s))' % (attr, ATTRS[attr]))
+            print('#else')
+            print('#define %s' % attr)
+            print('#endif')
+            print('#endif')
+        if used_attrs:
+            print('')
+
     def print_footer(self):
         footer = ''
         print(footer)
@@ -827,6 +871,8 @@ class PrinterHelpers(Printer):
                 print(' *{}{}'.format(' \t' if line else '', line))
 
         print(' */')
+        if helper.attrs:
+            print(" ".join(helper.attrs))
         print('static %s %s(* const %s)(' % (self.map_type(proto['ret_type']),
                                       proto['ret_star'], proto['name']), end='')
         comma = ''
-- 
2.46.0


