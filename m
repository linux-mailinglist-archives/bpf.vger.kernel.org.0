Return-Path: <bpf+bounces-46674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F99ED938
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 23:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2500283290
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C51F4E27;
	Wed, 11 Dec 2024 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="ednvdieJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C311F37DA
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954441; cv=none; b=SWGU0beRZC0swbQy8I2Z4jwCQ7IQRwhqFa3EduYHaMwNXr6cpR/b7/mjR4zBRX7jksisOcZESkGi7clTUzPOVcLUIcNoLxOKdGDHHBqbxn03r1TIfU5Ysr8yJWNzQoW789hEl8qd1So7/Nis/P86KCftpxGS+sTMEPf53rItcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954441; c=relaxed/simple;
	bh=QJRHSw6dNPAboHyNiN3LIsxg+Synrw002yRBaiHEkoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM/VXasE5FzY3u0WGKxL3zUHAqoeEXDHb2wt9kM8eF/uqBA8li4w18G5FdN1gB0MruP+jNZrNOI1704WwJ8LRjd7ONZqC4/67tCQEw8GIjqCyrt4HTe6HNaZGoY+Tpd2Fcy+voS/PnVhCiPn6VbjOTe7qrv4/FUBAclZpNAW+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=ednvdieJ; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1733954439; x=1765490439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJRHSw6dNPAboHyNiN3LIsxg+Synrw002yRBaiHEkoE=;
  b=ednvdieJcCiMzqDjyUecttNBZDw3H5iTBUkO6EvXrleEVm9+9DdZfZ6A
   qzZTK74YVBBfjpGybll+d4vcjmsPhzQ5sbcmkA52IxOxGTTurez5YoJd4
   5b2nAIm4/Id/zZor0XbjtM7oPomeXXWznRESG8nY3NKauJStxSPchyJZv
   Y=;
X-CSE-ConnectionGUID: Ni1Oit79TcqyyQnUml0NPA==
X-CSE-MsgGUID: qHrAH95BQMGhTLWghIw3+g==
X-IronPort-AV: E=Sophos;i="6.12,226,1728943200"; 
   d="scan'208";a="28138456"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 11 Dec 2024 23:00:37 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 6B02B27BA;
	Wed, 11 Dec 2024 23:00:36 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: bpf@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 1/1] selftests/bpf: clear out Python syntax warnings
Date: Wed, 11 Dec 2024 22:57:29 +0100
Message-ID: <20241211220012.714055-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalid escape sequences are used, and produced syntax warnings:

```
$ test_bpftool_synctypes.py
test_bpftool_synctypes.py:69: SyntaxWarning: invalid escape sequence '\['
  self.start_marker = re.compile(f'(static )?const bool {self.array_name}\[.*\] = {{\n')
test_bpftool_synctypes.py:83: SyntaxWarning: invalid escape sequence '\['
  pattern = re.compile('\[(BPF_\w*)\]\s*= (true|false),?$')
test_bpftool_synctypes.py:181: SyntaxWarning: invalid escape sequence '\s'
  pattern = re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
test_bpftool_synctypes.py:229: SyntaxWarning: invalid escape sequence '\*'
  start_marker = re.compile(f'\*{block_name}\* := {{')
test_bpftool_synctypes.py:229: SyntaxWarning: invalid escape sequence '\*'
  start_marker = re.compile(f'\*{block_name}\* := {{')
test_bpftool_synctypes.py:230: SyntaxWarning: invalid escape sequence '\*'
  pattern = re.compile('\*\*([\w/-]+)\*\*')
test_bpftool_synctypes.py:248: SyntaxWarning: invalid escape sequence '\s'
  start_marker = re.compile(f'"\s*{block_name} := {{')
test_bpftool_synctypes.py:249: SyntaxWarning: invalid escape sequence '\w'
  pattern = re.compile('([\w/]+) [|}]')
test_bpftool_synctypes.py:267: SyntaxWarning: invalid escape sequence '\s'
  start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
test_bpftool_synctypes.py:267: SyntaxWarning: invalid escape sequence '\s'
  start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
test_bpftool_synctypes.py:268: SyntaxWarning: invalid escape sequence '\w'
  pattern = re.compile('([\w-]+) ?(?:\||}[ }\]])')
test_bpftool_synctypes.py:287: SyntaxWarning: invalid escape sequence '\w'
  pattern = re.compile('(?:.*=\')?([\w/]+)')
test_bpftool_synctypes.py:319: SyntaxWarning: invalid escape sequence '\w'
  pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')
test_bpftool_synctypes.py:341: SyntaxWarning: invalid escape sequence '\|'
  start_marker = re.compile('\|COMMON_OPTIONS\| replace:: {')
test_bpftool_synctypes.py:342: SyntaxWarning: invalid escape sequence '\*'
  pattern = re.compile('\*\*([\w/-]+)\*\*')
```

Escaping them clears out the warnings.

```
$ tools/testing/selftests/bpf/test_bpftool_synctypes.py; echo $?
0
```

Link: https://docs.python.org/fr/3/library/re.html
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 .../selftests/bpf/test_bpftool_synctypes.py   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index 0ed67b6b31dd..238121fda5b6 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -66,7 +66,7 @@ class ArrayParser(BlockParser):
 
     def __init__(self, reader, array_name):
         self.array_name = array_name
-        self.start_marker = re.compile(f'(static )?const bool {self.array_name}\[.*\] = {{\n')
+        self.start_marker = re.compile(fr'(static )?const bool {self.array_name}\[.*\] = {{\n')
         super().__init__(reader)
 
     def search_block(self):
@@ -80,7 +80,7 @@ class ArrayParser(BlockParser):
         Parse a block and return data as a dictionary. Items to extract must be
         on separate lines in the file.
         """
-        pattern = re.compile('\[(BPF_\w*)\]\s*= (true|false),?$')
+        pattern = re.compile(r'\[(BPF_\w*)\]\s*= (true|false),?$')
         entries = set()
         while True:
             line = self.reader.readline()
@@ -178,7 +178,7 @@ class FileExtractor(object):
         @enum_name: name of the enum to parse
         """
         start_marker = re.compile(f'enum {enum_name} {{\n')
-        pattern = re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
+        pattern = re.compile(r'^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
         end_marker = re.compile('^};')
         parser = BlockParser(self.reader)
         parser.search_block(start_marker)
@@ -226,8 +226,8 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'\*{block_name}\* := {{')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        start_marker = re.compile(fr'\*{block_name}\* := {{')
+        pattern = re.compile(r'\*\*([\w/-]+)\*\*')
         end_marker = re.compile('}\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -245,8 +245,8 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'"\s*{block_name} := {{')
-        pattern = re.compile('([\w/]+) [|}]')
+        start_marker = re.compile(fr'"\s*{block_name} := {{')
+        pattern = re.compile(r'([\w/]+) [|}]')
         end_marker = re.compile('}')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -264,8 +264,8 @@ class FileExtractor(object):
 
         @macro: macro starting the block, 'HELP_SPEC_OPTIONS' in the example
         """
-        start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]])')
+        start_marker = re.compile(fr'"\s*{macro}\s*" [|}}]')
+        pattern = re.compile(r'([\w-]+) ?(?:\||}[ }\]])')
         end_marker = re.compile('}\\\\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -283,8 +283,8 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'local {block_name}=\'')
-        pattern = re.compile('(?:.*=\')?([\w/]+)')
+        start_marker = re.compile(fr'local {block_name}=\'')
+        pattern = re.compile(r'(?:.*=\')?([\w/]+)')
         end_marker = re.compile('\'$')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -316,7 +316,7 @@ class MainHeaderFileExtractor(SourceFileExtractor):
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
         start_marker = re.compile(f'"OPTIONS :=')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')
+        pattern = re.compile(r'([\w-]+) ?(?:\||}[ }\]"])')
         end_marker = re.compile('#define')
 
         parser = InlineListParser(self.reader)
@@ -338,8 +338,8 @@ class ManSubstitutionsExtractor(SourceFileExtractor):
 
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
-        start_marker = re.compile('\|COMMON_OPTIONS\| replace:: {')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        start_marker = re.compile(r'\|COMMON_OPTIONS\| replace:: {')
+        pattern = re.compile(r'\*\*([\w/-]+)\*\*')
         end_marker = re.compile('}$')
 
         parser = InlineListParser(self.reader)
-- 
2.47.1


