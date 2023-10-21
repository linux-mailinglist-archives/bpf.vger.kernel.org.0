Return-Path: <bpf+bounces-12905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8EA7D2073
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632DC2818A1
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94C21108;
	Sat, 21 Oct 2023 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="kFmr1ky+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770911B292
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 23:27:02 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E84D67
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 16:26:56 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d2f3bb312so13700266d6.0
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1697930815; x=1698535615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzsyftbU+bhDbSsPHhCKGUfVKc4vWY0rz1ewQJcXDAs=;
        b=kFmr1ky+mq35m9aDBqwcVKmkfE+QSeZi+E3vrkiFCDqwwv4F6Xgl/L/GnIqZowop+y
         V8GGuc2f0iTwkdEmHR74fGDvmsHTjslUoEqUJw29TojbtIf93yGqk0oFJSUljSTn9wlw
         l5uXA83Abw/h/CzsnxdVnXmqizu/vTqsVRI1JrVOKm8pqxCh+E0dvaOJBk46CE9sSc4L
         FQO3pKD3WfF2IEAH6EL/piKvF921mxQKyzACkOLrUxVtqWyJD9xKvewlGfH71VeWrP8d
         Hi3H/7GsrFeVaZZof8hy8rhAJibV1F9OQo5jQeAaFr5gvSKctMWcT0fLvaGgHZeOdkDy
         dzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697930815; x=1698535615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzsyftbU+bhDbSsPHhCKGUfVKc4vWY0rz1ewQJcXDAs=;
        b=hJZPcREWWUbC+zaZ9xVyH8X4p4nZ8uXOmA9eKGYHzB9877824vvACpM65VYOkcMZgZ
         3tbSz7NaCJKhdVf3DfsSJclvfkSf/Zk7QGcQhJ0RK9ec7v7PhWXZXu5KE0wbKAwoFuWx
         mbgQJUV5R5IvuBuHu7NJNc1nlX8caOF61k3MeWhyUPrmVZSLllWps+wkQKAo5aVutOD8
         UcHIiJbKO81hj/QdequDD9dy1fAC+bNAESSicqLqL/t6/s8YN72mY0mHfEqAjwpNYA8W
         qPncrqHOO9O2abP/o7Fb0KZmi6mrIGzZbGPec3isFdQchS3LcISkO1NkVdn4gnAXS3PT
         CP2Q==
X-Gm-Message-State: AOJu0Yyt2TFlQ0cBBOW4ilFLd9VspuqiS8I7upfmIRcWANC1P208mspu
	vDUaFTiW14FU2QtCiOX7Rhq4Qw==
X-Google-Smtp-Source: AGHT+IGusCA/tFCiNoTZGGwvn4do0P4vrWyHgvz2l3t8n8Ju64R0a9ABQd1utf5Fjg1aTK8nTrq9oA==
X-Received: by 2002:a05:6214:e6c:b0:66d:9d6:633a with SMTP id jz12-20020a0562140e6c00b0066d09d6633amr6167052qvb.33.1697930815045;
        Sat, 21 Oct 2023 16:26:55 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id d27-20020a0cb2db000000b0066cf09f5ba9sm1780153qvf.131.2023.10.21.16.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 16:26:54 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@ietf.org,
	bpf@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v2] bpf, docs: Add additional ABI working draft base text
Date: Sat, 21 Oct 2023 19:26:32 -0400
Message-ID: <20231021232636.3546258-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CADx9qWjcSoNb=aWpDVV5QxEoUGuDr2=wOOz3AWhjemh6+hzhwA@mail.gmail.com>
References: <CADx9qWjcSoNb=aWpDVV5QxEoUGuDr2=wOOz3AWhjemh6+hzhwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

diff --git a/Documentation/bpf/standardization/abi.rst b/Documentation/bpf/standardization/abi.rst
index 0c2e10eeb89a..f6a87b7a300c 100644
--- a/Documentation/bpf/standardization/abi.rst
+++ b/Documentation/bpf/standardization/abi.rst
@@ -1,18 +1,162 @@
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
+
+**Author's Note**: Red Hat specifies different levels of conformance over
+time [RHELABI]_.
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
+**TODO**
+
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
 
-Registers and calling convention
-================================
+Frame Pointer Register
+^^^^^^^^^^^^^^^^^^^^^^
+The use of a frame pointer by programs is not required. If, however, a BPF
+program does use a frame pointer, it must be stored in register `r10` and
+must be read only.
 
-BPF has 10 general purpose registers and a read-only frame pointer register,
-all of which are 64-bits wide.
+Data Types
+----------
+
+Numeric Types
+^^^^^^^^^^^^^
+
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
 
@@ -23,3 +167,100 @@ The BPF calling convention is defined as:
 
 R0 - R5 are scratch registers and BPF programs needs to spill/fill them if
 necessary across calls.
+
+Every function invocation proceeds as if it has exclusive access to an
+implementation-defined amount of stack space. R10 is a pointer to the byte of
+memory with the highest address in that stack space. The contents
+of a function invocation's stack space do not persist between invocations.
+
+**TODO** Discuss manufactured prologue and epilogue. Take language from the
+design FAQ.
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
+**Author's Note** libbpf currently defines the return value of an ebpf program
+as a 32-bit unsigned integer.
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
+**Author's Note** This information may end up as a subsection somewhere else.
+
+BPF Maps
+=========
+**Author's Note** This information may end up as a subsection somewhere else.
+
+System Calls
+============
+
+**TODO**
+
+C Programming Language Support
+==============================
+
+**Author's Note** This section could be included in order to define the contents
+of standardized processor-specific header files that would make it easier
+for programmers to write programs.
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
+             https://www.sco.com/developers/devspecs/gabi41.pdf
+.. [POWERPCABI] Developing PowerPC Embedded Application Binary Interface (EABI)
+                Compliant Programs. PowerPC Embedded Processors Application Note. IBM. 1998. http://class.ece.iastate.edu/arun/Cpre381_Sp06/lab/labw12a/eabi_app.pdf
+.. [GOABI] Go internal ABI specification. Go Source Code. No authors. 2023.
+           https://go.googlesource.com/go/+/refs/heads/master/src/cmd/compile/abi-internal.md
+.. [JAVAABI] The Java (r) Language Specification - Java SE 7 Edition. Gosling, James et. al.
+             Oracle. 2013. https://docs.oracle.com/javase/specs/jls/se7/html/index.html
+.. [DALVIKABI] Dalvik Bytecode. Android Core Runtime Documentation. No authors. Google.
+               2022. https://source.android.com/docs/core/runtime/dalvik-bytecode
+.. [CLRABI] CLR ABI. The Book of the Runtime. No authors. Microsoft. 2023.
+            https://github.com/dotnet/coreclr/blob/master/Documentation/botr/clr-abi.md.
+.. [CSTD] International Standard: Programming Languages - C. ISO/IEC. 2018.
+          https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf.
+.. [RHELABI] Red Hat Enterprise Linux 8: Application Compatibility Guide. Red Hat.
+            2023. https://access.redhat.com/articles/rhel8-abi-compatibility.
-- 
2.41.0


