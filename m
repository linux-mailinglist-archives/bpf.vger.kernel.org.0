Return-Path: <bpf+bounces-14126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA37E0AB4
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48727281F92
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A223761;
	Fri,  3 Nov 2023 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="i2Aa1agz";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="i2Aa1agz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="Wuzoa1hj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19933E9
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 21:29:14 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B708187
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 14:29:12 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C9C95C090379
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699046438; bh=TNkir4VMjCkJbQO9pCNbf2q+Dw6g77CKM7FY0zg3Bp0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=i2Aa1agzX7vvEOJBmbFnIWvQ1rqKljYkhFaVFvy2uO85xRSJ1hR/TZcoVt3P7txMZ
	 0iglW77gvThZaVChT3KZI/ZbF6JoFj1F9eKQg8pyK3N/yL/uzhdhSWJ8bYvy78fau1
	 nKq+/1yJxx1umJx4aoZMTBHG1OfY+h9+t1Ljmptg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Nov  3 14:20:38 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 93973C09BB69;
	Fri,  3 Nov 2023 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699046438; bh=TNkir4VMjCkJbQO9pCNbf2q+Dw6g77CKM7FY0zg3Bp0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=i2Aa1agzX7vvEOJBmbFnIWvQ1rqKljYkhFaVFvy2uO85xRSJ1hR/TZcoVt3P7txMZ
	 0iglW77gvThZaVChT3KZI/ZbF6JoFj1F9eKQg8pyK3N/yL/uzhdhSWJ8bYvy78fau1
	 nKq+/1yJxx1umJx4aoZMTBHG1OfY+h9+t1Ljmptg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C33C7C09BB69
 for <bpf@ietfa.amsl.com>; Fri,  3 Nov 2023 14:20:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.905
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rIULwbUgBmUX for <bpf@ietfa.amsl.com>;
 Fri,  3 Nov 2023 14:20:32 -0700 (PDT)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0EABEC1E4E69
 for <bpf@ietf.org>; Fri,  3 Nov 2023 14:20:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-41cc0e9d92aso13605141cf.3
 for <bpf@ietf.org>; Fri, 03 Nov 2023 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699046431; x=1699651231;
 darn=ietf.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYdMHYdkxv9YGFAGS4ea9ZET/wh9tKXSAiGMgB9yMoI=;
 b=Wuzoa1hjhij7QARTrl6Q6db6bkUyS6xR5jtOAuZ+a+Oid1A6Jz7kzWIB7kxMvX9Q2a
 D3N/aGndyobwMZ6MXvPPozHVqODcHSTB1Q5ze9/TkwVP5PvrF+V1LoukMBnzMEIKeYqH
 q8cPkJnQOGj9gU+ix5R73bBvhzyYzwSK367lhK2eqMpm0KbXdTYeWo0REMQhxeqHhWtv
 1DCfJnZUBOyOaG7PRDCOoXNbtDJio7dNg9pY5BMeuBtHOU4ii8aVut6m5h5qIpxeu/UT
 llPNJsHf7ERIOop6ABwPu2pIZ8bkFW9W2vZsp8xRY6GDmAhON5W+95AiDf4k30ED3NEQ
 6cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699046431; x=1699651231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYdMHYdkxv9YGFAGS4ea9ZET/wh9tKXSAiGMgB9yMoI=;
 b=P7wzng31j+94skjKKqIEi8/qWqehaddRBnPH9LDleBuiziG9/VbOQ1f352/yHpd74x
 Jc43F7oHMIEJtwNc0AdiIJKE0qhN+SnkD1MX0hqHnKzctxzDol0PfvN5Ie4MI7ZjheZQ
 4OS7kj3PJ3+IQBgz+SePRXVnW+F6j7KMlNg5hEYd/AfVG6Aczk4vsWEaKX15wx9I+NvV
 nLnhCA3JmJSg8dmXuH2TA4NAnC99fuR/lgmHTj3SPL97CHZpJw1SJ6pC7W06+LMQblBz
 FVqynLHcrQr9GEku1nVxOjbawR7LPX+ZhbPz83MYCNJB/Ey6bhqJ/G3G4JaC9h6BZ4TU
 rjcw==
X-Gm-Message-State: AOJu0Yx1jBVxDqyCTPRebYgUs2cKS24RU5s76NT+MoD0c3LEBczXIvKC
 P9nyneTGALJMVu3b9ypEVBP09rUtCj0CqqxFHUQ=
X-Google-Smtp-Source: AGHT+IFqCI4rSD3t0TdoP+wfoqu8rBfh8hKCUOCT5FmRSXzqYjBzqh/Vm2U7BbNxaVfAw+Gib2L7WA==
X-Received: by 2002:a05:622a:181b:b0:41c:c6b4:8c0d with SMTP id
 t27-20020a05622a181b00b0041cc6b48c0dmr26078423qtc.9.1699046430756; 
 Fri, 03 Nov 2023 14:20:30 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 p25-20020ac84619000000b0041aff9339a2sm1028503qtn.22.2023.11.03.14.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 14:20:30 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@ietf.org,
	bpf@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Fri,  3 Nov 2023 17:20:16 -0400
Message-ID: <20231103212024.327833-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/XJy3kDqHl91yzurlvOUNfVptn0E>
Subject: [Bpf] [PATCH v3] bpf,
 docs: Add additional ABI working draft base text
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

Per David's description of the IETF standardization process, this
document will form the basis for an informational eBPF ABI. The
work in this commit is a slightly more complete skeleton for the work
that we will do. Everything in this document (from formatting to topics
to details) is open for change and feedback.
---
 Documentation/bpf/standardization/abi.rst | 259 +++++++++++++++++++++-
 1 file changed, 250 insertions(+), 9 deletions(-)

 Changelog:
   v1 -> v2:
     - Address David's comments
		 - Reflow to a max of 80 character lines (Christoph's feedback)
   v2 -> v3:
     - Update Java Language Specification reference to version 21
		 - Make author's notes into comments.
		 - Fix minor typographical errors in References section.

diff --git a/Documentation/bpf/standardization/abi.rst b/Documentation/bpf/standardization/abi.rst
index 0c2e10eeb89a..8bb7383688bc 100644
--- a/Documentation/bpf/standardization/abi.rst
+++ b/Documentation/bpf/standardization/abi.rst
@@ -1,18 +1,159 @@
-.. contents::
-.. sectnum::
-
 ===================================================
 BPF ABI Recommended Conventions and Guidelines v1.0
 ===================================================
 
-This is version 1.0 of an informational document containing recommended
-conventions and guidelines for producing portable BPF program binaries.
+An application binary interface (ABI) defines the requirements that one or more
+binary software objects must meet in order to guarantee that they can
+interoperate and/or use the resources provided by operating systems/hardware
+combinations.  (For alternate definitions of ABI, see [SYSVABI]_, [POWERPCABI]_)
+
+The purpose of this document is to define an ABI which will define the extent
+to which compiled BPF programs are compatible with each other and the BPF
+machine/processor [#]_ on which they are executing.
+
+The ABI is specified in two parts: a generic part and a processor-specific part.
+A pairing of generic ABI with the processor-specific ABI for a certain
+instantiation of a BPF machine represents a complete binary interface for BPF
+programs executing on that machine.
+
+This document is the generic ABI and specifies the parameters and behavior
+common to all instantiations of BPF machines. In addition, it defines the
+details that must be specified by each processor-specific ABI.
+
+These psABIs are the second part of the ABI. Each instantiation of a BPF
+machine must describe the mechanism through which binary interface
+compatibility is maintained with respect to the issues highlighted by this
+document. However, the details that must be defined by a psABI are a minimum --
+a psABI may specify additional requirements for binary interface compatibility
+on a platform.
+
+.. contents::
+.. sectnum::
+
+How To Use This ABI
+===================
+
+Conformance
+===========
+..
+   Red Hat specifies different levels of conformance over time [RHELABI]_. We
+   could use information from that document here, if we want.
+
+Related Work
+============
+BPF programs are not unique for the way that they operate on a virtualized
+machine and processor.  There are many programming languages that compile to an
+ISA that is specific to a virtual machine.  Like the specification presented
+herein, those languages and virtual machines also have ABIs.
+
+For example, the Go programming language and the runtime included statically
+with each program compiled from Go source code have a defined ABI [GOABI]_.
+Java programs compiled to bytecode follow a well-defined ABI for
+interoperability with other compiled Java programs and libraries [JAVAABI]_.
+Programs compiled to bytecode for execution as user applications on the Android
+operating system (OS) adhere to a bytecode specification that shares much in
+common with an ABI [DALVIKABI]_. Finally, the Common Language Runtime (CLR)
+designed to execute programs compiled to the Microsoft Intermediate Language
+(MSIL) has a fully specified ABI [CLRABI]_.
+
+Vocabulary
+==========
+
+#. Program: A BPF Program is an ordered set of BPF instructions, with exactly
+   one entry instruction where the program begins, and one or more exit
+   instructions where program execution can end.
+#. Program Type: Every BPF program has an associated type. The program type
+   defines, among other things, a program's possible attach types.
+#. Attach Type: An attach type defines the set of BPF hook points to which a BPF
+   program can attach.
+#. BPF Hook Points: Places in a BPF-enabled component (e.g., the Linux Kernel,
+   the Windows kernel) where a BPF program may be attached.
+#. ABI-conforming BPF Machine Instantiation: A physical or logical realization
+   of a computer system capable of executing BPF programs consistently with the
+   specifications outlined in this document.
+#. ABI-conforming BPF program: A BPF program written to include only the system
+   routines, commands, and other resources included in this ABI; or a BPF
+   program compiled into an executable file that has the formats and
+   characteristics specified for such files in this ABI; or a BPF program whose
+   behavior complies with the rules given in the ABI [SYSVABI]_.
+#. ABI-nonconforming program: A BPF program that is not ABI conforming.
+#. Undefined Behavior: Behavior that may vary from instance to instance or may
+   change at some time in the future. Some undesirable programming practices
+   are marked in this ABI as yielding undefined behavior [SYSVABI]_.
+#. Unspecified Property: A property of an entity defined in this document that
+   is not explicitly included, defined or referenced in this specification, and
+   may change at some time in the future. In general, it is not good practice
+   to make a program depend on an unspecified property [SYSVABI]_.
+
+Program Execution Environment
+=============================
+
+A loaded BPF program is executed in a freestanding or hosted environment. [#]_.
+
+BPF Program Freestanding Execution Environment
+----------------------------------------------
+
+BPF Program Hosted Execution Environment
+----------------------------------------
+
+A hosted execution environment is one in which a BPF machine instantiation is
+embedded within another computer system known as a BPF-enabled application
+(e.g., a user application or an operating system kernel). A loaded BPF program
+can be attached to a BPF hook point in such a BPF-enabled application
+compatible with the attach type of its program type.  When the BPF-enabled
+application's execution reaches a BPF hook point to which a BPF program is
+attached, that BPF program begins execution on the embedded BPF machine at the
+program's first instruction. The contents of the embedded BPF machine's
+registers and memory at the time it starts execution of the BPF program are
+defined by the BPF program's type and attach point.
+
+Processor Architecture
+======================
+
+This section describes the processor architecture available
+to programs. It also defines the reference language data types, giving the
+foundation for system interface specifications [SYSVABI]_
+
+Registers
+---------
+
+General Purpose Registers
+^^^^^^^^^^^^^^^^^^^^^^^^^
+BPF has 11 64-bit wide registers, `r0` - `r10`. There exists a single
+32-bit wide subregister for each one of the 11 64-bit wide registers. Those
+registers do not have their own names -- they are accessible indirectly
+through the 32-bit ALU instructions.
+
+The contents of the registers at the beginning of a BPF program's
+execution depend on the program's type.
+
+Frame Pointer Register
+^^^^^^^^^^^^^^^^^^^^^^
+The use of a frame pointer by programs is not required. If, however, a BPF
+program does use a frame pointer, it must be stored in register `r10` and
+must be read only.
+
+Data Types
+----------
 
-Registers and calling convention
-================================
+Numeric Types
+^^^^^^^^^^^^^
 
-BPF has 10 general purpose registers and a read-only frame pointer register,
-all of which are 64-bits wide.
+The BPF machine supports 32- and 64-bit signed and unsigned integers. It does
+not support floating-point data types. All signed integers are represented in
+twos-complement format where the sign bit is stored in the most-significant bit.
+
+Pointers
+^^^^^^^^
+
+Function Calling Sequence
+=========================
+This section defines the standard function calling sequence in a way that
+accommodates exceptions, stack management, register (non)volatility, and access
+to capabilities of the hosting environment (where applicable).
+
+Functions in BPF may define between 0 and 5 parameters. Each of the arguments in
+a function call are passed in registers.
 
 The BPF calling convention is defined as:
 
@@ -23,3 +164,103 @@ The BPF calling convention is defined as:
 
 R0 - R5 are scratch registers and BPF programs needs to spill/fill them if
 necessary across calls.
+
+Every function invocation proceeds as if it has exclusive access to an
+implementation-defined amount of stack space. R10 is a pointer to the byte of
+memory with the highest address in that stack space. The contents
+of a function invocation's stack space do not persist between invocations.
+
+..
+   Discuss manufactured prologue and epilogue. Take language from the design FAQ.
+
+Execution Environment Interface
+===============================
+
+When a BPF program executes in a hosted environment, the hosted environment
+may make available to BPF programs certain capabilities. This section
+describes those capabilities and the mechanism for accessing them.
+
+
+Program Execution
+=================
+
+Program Return Values
+---------------------
+
+..
+   libbpf currently defines the return value of a bpf program as a 32-bit unsigned
+   integer. ubpf currently defines the return value of a bpf program.
+
+Program Loading and Dynamic Linking
+-----------------------------------
+This section describes the object file information and system actions that
+create running programs. Some information here applies to all systems;
+information specific to one processor resides in sections marked accordingly
+[SYSVABI]_.
+
+BPF programs saved in ELF files must be loaded from storage and properly
+configured before they can be executed on a BPF machine.
+
+Program Loading (Processor-Specific)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Dynamic Linking
+^^^^^^^^^^^^^^^
+
+Global Offset Table (Processor-Specific)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Procedure Linkage Table (Processor-Specific)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Exception Handling
+==================
+
+BPF Program Types
+==================
+.. This information may end up as a subsection somewhere else.
+
+BPF Maps
+=========
+.. This information may end up as a subsection somewhere else.
+
+System Calls
+============
+
+**TODO**
+
+C Programming Language Support
+==============================
+
+..
+   This section could be included in order to define the contents of standardized
+   processor-specific header files that would make it easier for programmers to
+   write programs.
+
+Notes
+=====
+.. [#] The BPF machine does not need to be a physical instantiation of a processor.
+       In fact, many instantiations of BPF machines are virtual.
+.. [#] See the [CSTD]_ for the inspiration for this distinction.
+
+References
+==========
+
+.. [SYSVABI] System V Application Binary Interface - Edition 4.1. SCO Developer Specs.
+             The Santa Cruz Operation. 1997.
+             https://www.sco.com/developers/devspecs/gabi41.pdf.
+.. [POWERPCABI] Developing PowerPC Embedded Application Binary Interface (EABI)
+                Compliant Programs. PowerPC Embedded Processors Application Note. IBM. 1998.
+                http://class.ece.iastate.edu/arun/Cpre381_Sp06/lab/labw12a/eabi_app.pdf.
+.. [GOABI] Go internal ABI specification. Go Source Code. No authors. 2023.
+           https://go.googlesource.com/go/+/refs/heads/master/src/cmd/compile/abi-internal.md.
+.. [JAVAABI] The Java (r) Language Specification - Java SE 21 Edition. Gosling, James et. al.
+             Oracle. 2023. https://docs.oracle.com/javase/specs/jls/se21/html/index.html.
+.. [DALVIKABI] Dalvik Bytecode. Android Core Runtime Documentation. No authors. Google.
+               2022. https://source.android.com/docs/core/runtime/dalvik-bytecode.
+.. [CLRABI] CLR ABI. The Book of the Runtime. No authors. Microsoft. 2023.
+            https://github.com/dotnet/coreclr/blob/master/Documentation/botr/clr-abi.md.
+.. [CSTD] International Standard: Programming Languages - C. ISO/IEC. 2018.
+          https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf.
+.. [RHELABI] Red Hat Enterprise Linux 8: Application Compatibility Guide. Red Hat.
+            2023. https://access.redhat.com/articles/rhel8-abi-compatibility.
-- 
2.41.0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

