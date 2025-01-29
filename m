Return-Path: <bpf+bounces-50029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C5A21F00
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 15:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A0D1882EA1
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07471DA0E0;
	Wed, 29 Jan 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djFiyaI1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0FD1B4250;
	Wed, 29 Jan 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160531; cv=none; b=MqzDk1aNZ+SSNVjv43r4DyISKUzQeEur/oOfPpDJVbGMYIhfSoem97n2BmiBhK0LOSlbUi6MHFZMfYIHkszoGcX92cm12kX+0gBhYvhpZ0agiWJyX50xHbA2Vi80OMyiKsC13Ly+IxtIKsD73SR11miLV9aFhQ8o4Nw35yCqzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160531; c=relaxed/simple;
	bh=/uy2KVK+92bnjkNkIT1iw5CrTdiZ0e2lwuNq07xf8OM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIjz3OvimteobWYLHRjzWMXoKzWhEPpYBp/O6JqsOwdVvdewpUnFs1NaqCTilPqJWha4nHJJxRgrUqN6Ert/SPUSHV3gZV96iRKaCGnvu0jrAToRkBvclybo2sg/eWRoCriqyANIdJ1Hi/K9TsDOeM+JG4ZBtncizAKGRA2A1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djFiyaI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A63C4CED3;
	Wed, 29 Jan 2025 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738160530;
	bh=/uy2KVK+92bnjkNkIT1iw5CrTdiZ0e2lwuNq07xf8OM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djFiyaI1DlJWiFHE8181GXXxjAr3wEqHuYYG3QsXELwZvDKxnRVxjUbFdIQbTnmLU
	 Lt9fufnc/G7WtGz9dtGAS3ZPyc4zzMF7RCfLnP+iBbDKwR+eb444lgkHrtJ/IVzKnP
	 WXttUr2Yxs6fWKBISWq0/x5ZYEIrKYg1CFR9lX/xH1tZyDicoyC+ae2lT5AysNsQ5+
	 Zrzl0ec3PcPgnqhqfetOvYwj+teyI/gwI8joVAbOMvx/WjRa3zWtMYKccoxnJSJUEq
	 elKqiXQFndQZbOtUJb0kgnqPfoQifhZUjqbQYA3D92ZpRy6VKsPv9SGhYwjgHdtLhq
	 gPYPXMPtSHgOQ==
Date: Wed, 29 Jan 2025 15:22:03 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2 00/38] Improve ABI documentation generation
Message-ID: <20250129152203.0dda53ca@foz.lan>
In-Reply-To: <20250129024518.69c0be81@foz.lan>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
	<87h65i7e87.fsf@trenco.lwn.net>
	<20250129024518.69c0be81@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 29 Jan 2025 02:45:18 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> > I've only tested with current Sphinx,
> > have you tried this with the more ancient versions we support?  
> 
> Not yet, but I double-checked at Sphinx documentation to be sure that
> I won't be using any newer methods: I just kept using the same Sphinx
> API as used by other extensions at the Kernel.

Just checked it with Python 3.6 and Sphinx 3.4 on Fedora 41 with:

	sudo dnf install python3.6.x86_64
	python3.6 -m venv Sphinx-3.4
	pip install alabaster Sphinx==3.4.3 pyyaml

There were some issues related to problems with early f-string
support, as reported by Akira.

After applying the enclosed patch, it is now working fine. The only
drawback is here:

	- print(f"Defined on file{'s'[:len(files) ^ 1]}:\t{", ".join(files)}")
	+ print("Defined on file(s):\t" + ", ".join(files))

As I removed the file/files auto-plural logic depending on the files
array length. Not a big deal.

I'll double-check if there's no other diff between old/new version
and add the enclosed patch in the end.

Thanks,
Mauro

[PATCH] scripts/get_abi.py: make it backward-compatible with Python 3.6

Despite being introduced on Python 3.6, the original implementation
was too limited: it doesn't accept anything but the argument.

Even on python 3.10.12, support was still limited, as more complex
operations cause SyntaxError:

	Exception occurred:
	  File ".../linux/Documentation/sphinx/kernel_abi.py", line 48, in <module>
	    from get_abi import AbiParser
	  File ".../linux/scripts/get_abi.py", line 525
	    msg += f"{part}\n{"-" * len(part)}\n\n"
                       ^
	SyntaxError: f-string: expecting '}'

Replace f-strings by normal string concatenation when it doesn't
work on Python 3.6.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/get_abi.py b/scripts/get_abi.py
index 543bed397c8c..e6e94f721fff 100755
--- a/scripts/get_abi.py
+++ b/scripts/get_abi.py
@@ -522,7 +522,7 @@ class AbiParser:
 
                 if cur_part and cur_part != part:
                     part = cur_part
-                    msg += f"{part}\n{"-" * len(part)}\n\n"
+                    msg += part + "\n"+ "-" * len(part) +"\n\n"
 
                 msg += f".. _{key}:\n\n"
 
@@ -546,7 +546,7 @@ class AbiParser:
                     msg += f"Defined on file :ref:`{base} <{ref[1]}>`\n\n"
 
             if wtype == "File":
-                msg += f"{names[0]}\n{"-" * len(names[0])}\n\n"
+                msg += names[0] +"\n" + "-" * len(names[0]) +"\n\n"
 
             desc = v.get("description")
             if not desc and wtype != "File":
@@ -570,7 +570,8 @@ class AbiParser:
 
             users = v.get("users")
             if users and users.strip(" \t\n"):
-                msg += f"Users:\n\t{users.strip("\n").replace('\n', '\n\t')}\n\n"
+                users = users.strip("\n").replace('\n', '\n\t')
+                msg += f"Users:\n\t{users}\n\n"
 
             ln = v.get("line_no", 1)
 
@@ -596,7 +597,9 @@ class AbiParser:
                 elif len(lines) == 1:
                     f.append(f"{fname}:{lines[0]}")
                 else:
-                    f.append(f"{fname} lines {", ".join(str(x) for x in lines)}")
+                    m = fname + "lines "
+                    m += ", ".join(str(x) for x in lines)
+                    f.append(m)
 
             self.log.warning("%s is defined %d times: %s", what, len(f), "; ".join(f))
 
@@ -644,10 +647,11 @@ class AbiParser:
                     if users:
                         print(f"Users:\t\t\t{users}")
 
-                    print(f"Defined on file{'s'[:len(files) ^ 1]}:\t{", ".join(files)}")
+                    print("Defined on file(s):\t" + ", ".join(files))
 
                     if desc:
-                        print(f"\n{desc.strip("\n")}\n")
+                        desc = desc.strip("\n")
+                        print(f"\n{desc}\n")
 
         if not found_keys:
             print(f"Regular expression /{expr}/ not found.")

