Return-Path: <bpf+bounces-11208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0D7B54D9
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 16:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2B70B1C208E0
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0119BDD;
	Mon,  2 Oct 2023 14:20:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCA19BD4
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 14:20:43 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3AB8
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 07:20:41 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 52A5EC137391
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696256423; bh=+9Ou2bOFZ+xTQZlmo0GWHuEVyj6VowNQe+2O97L1Gpo=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=qWc3k0R2fa/bOX8JcQ7HNrgQth5njPcvpzdkIdhXR0mivsZWXzkCemXtLkOTgByTW
	 XudiIO4GVrC0jZFfARX9s92DyW6epE3i2EANtoXAsRa+jCd3MOr/L9Cqd7bqBTDBW1
	 CIBO8T1nNEu+kHeW0SYKwfyYHxLOij8vTf6pag2E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Oct  2 07:20:23 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2B59DC13AE39;
	Mon,  2 Oct 2023 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696256423; bh=+9Ou2bOFZ+xTQZlmo0GWHuEVyj6VowNQe+2O97L1Gpo=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=qWc3k0R2fa/bOX8JcQ7HNrgQth5njPcvpzdkIdhXR0mivsZWXzkCemXtLkOTgByTW
	 XudiIO4GVrC0jZFfARX9s92DyW6epE3i2EANtoXAsRa+jCd3MOr/L9Cqd7bqBTDBW1
	 CIBO8T1nNEu+kHeW0SYKwfyYHxLOij8vTf6pag2E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7AD12C13AE31
 for <bpf@ietfa.amsl.com>; Mon,  2 Oct 2023 07:20:21 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.903
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sd4BT16BR2ty for <bpf@ietfa.amsl.com>;
 Mon,  2 Oct 2023 07:20:16 -0700 (PDT)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C3B5FC13AE42
 for <bpf@ietf.org>; Mon,  2 Oct 2023 07:20:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-41807974fc1so94027131cf.2
 for <bpf@ietf.org>; Mon, 02 Oct 2023 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1696256415; x=1696861215;
 darn=ietf.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CalXzW/QxBa1EtyDoklmyMRztf4QFZi5mTpRW7rLVnQ=;
 b=SgDke1g3e8MqHdOwZBc3kVRk/SzRQsRzsxqmKaILEWfMZzXrpt5SmRaffqltN7ooV2
 wj39uX++jqE3yRHU9uUFusIoDe98FXYjoMNMHIkhaPWaI4ut93skgZilCwxiRe9HHkbc
 ZeODy3nXi86/E8ZT5EkpjktCKxh42aBbSGQpp87YcI4lOz6SQ9OdYmIux91Ff7OtvceS
 EJ8T2iNHEe9T6wPIW38YNpudoU+TGEVPVlVZhAQazQcVLFvG7lHDRiSbm8arJY8l2NWK
 8iZgUo2H8sDaC1AIStr6qGm1352/Lkw5cx8792ncS1MJg8vUGickpYYFXXAJu6R04cT1
 FnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696256415; x=1696861215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CalXzW/QxBa1EtyDoklmyMRztf4QFZi5mTpRW7rLVnQ=;
 b=Z+cjNnFpkJohxqk6ccw8xWvwJXLLyYxi/YS18xiJO5CDYNsYOft2oh5F9tg4H6uEr2
 rbMmnoeAt6m8BCSX+X5iUsG9zwhhU0WArBQCGS02z4El+WV43FQxEUGrKPN/qHrYDztN
 aTli83uvfTMnZKJP+dCLz2+RqefVKY/ZKzF0JHmarBOzQAs3KmdsjPFwh8skhfglXvlM
 GIbqGNXriAe0AniQXdzFrpB6Xylnr+ZNr8FZ2SjggqAq9Zb4ueyZQTGus90AF+xwGgk7
 DtLICDxOnc2CW3irGTccCqPe15+cth+dMDObt9pgzPJ2OwnEpRiJxudPGasnsjKjXu7y
 9Fcg==
X-Gm-Message-State: AOJu0YykJSZglk9gO0Simv2JN/S8pzseVKtxqZNBCQ4fVHJq9yEvhao+
 C01w5JTtIKY1/m5cPH7nPxgWyJEljI7Pl+d6UXw=
X-Google-Smtp-Source: AGHT+IHdP6gMLvV/kqfL1X2MmPvY08m/1kgw8ZXJxyfLVznodmstPU7w/MmxCOBWk3ysnHEdNVF3QQ==
X-Received: by 2002:a05:622a:1819:b0:417:9646:8e2 with SMTP id
 t25-20020a05622a181900b00417964608e2mr13184963qtc.17.1696256415306; 
 Mon, 02 Oct 2023 07:20:15 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020ac8710f000000b00418142e802bsm6123819qto.6.2023.10.02.07.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:20:14 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@ietf.org,
	bpf@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Mon,  2 Oct 2023 10:19:55 -0400
Message-ID: <20231002142001.3223261-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/qaerxH39lMmDAD-qnxEv7Z98RHM>
Subject: [Bpf] [PATCH] bpf, docs: Add additional ABI working draft base text
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
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Per David's description of the IETF standardization process, this
document will form the basis for an informational eBPF ABI. The
work in this commit is a slightly more complete skeleton for the work
that we will do. Everything in this document (from formatting to topics
to details) is open for change and feedback.
---
 Documentation/bpf/standardization/abi.rst | 237 ++++++++++++++++++++--
 1 file changed, 225 insertions(+), 12 deletions(-)

diff --git a/Documentation/bpf/standardization/abi.rst b/Documentation/bpf/standardization/abi.rst
index 0c2e10eeb89a..cadbd1b4d6b3 100644
--- a/Documentation/bpf/standardization/abi.rst
+++ b/Documentation/bpf/standardization/abi.rst
@@ -1,25 +1,238 @@
-.. contents::
-.. sectnum::
-
 ===================================================
 BPF ABI Recommended Conventions and Guidelines v1.0
 ===================================================
 
-This is version 1.0 of an informational document containing recommended
-conventions and guidelines for producing portable BPF program binaries.
+An application binary interface (ABI) defines the requirements that one or more binary software
+objects must meet in order to guarantee that they can interoperate and/or use the resources provided
+by operating systems/hardware combinations.  (For alternate definitions of ABI, see
+[SYSVABI]_, [POWERPCABI]_)
+
+The purpose of this document is to define an ABI which will define the extent to which compiled
+eBPF programs are compatible with each other and the eBPF machine/processor [#]_ on which they
+are executing.
+
+The ABI is specified in two parts: a generic part and a processor-specific part.
+A pairing of of generic ABI with the processor-specific ABI for a certain instantiation
+of an eBPF machine represents a complete binary interface for eBPF programs executing
+on that machine.
+
+This document is a generic ABI and specifies the parameters and behavior common to all
+instantiations of eBPF machines. In addition, it defines the details that must be specified by each
+processor-specific ABI. 
+
+These psABIs are the second part of the ABI. Each instantiation of an eBPF machine must
+describe the mechanism through which binary interface compatibility is maintained with
+respect to the issues highlighted by this document. However, the details that must be
+defined by a psABI are a minimum -- a psABI may specify additional requirements for binary
+interface compatibility on a platform.
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
+Note: Red Hat specifies different levels of conformance over time [RHELABI]_.
+
+Related Work
+============
+eBPF programs are not unique for the way that they operate on a virtualized machine and processor.
+There are many programming languages that compile to an ISA that is specific to a virtual machine.
+Like the specification presented herein, those languages and virtual machines also have ABIs.
+
+For example, the Go programming language and the runtime included statically with each program compiled
+from Go source code have a defined ABI [GOABI]_. Java programs compiled to bytecode follow a well-defined
+ABI for interoperability with other compiled Java programs and libraries [JAVAABI]_. Programs compiled to
+bytecode for execution as user applications on the Android operating system (OS) adhere to a bytecode
+specification that shares much in common with an ABI [DALVIKABI]_. Finally, the Common Language Runtime (CLR)
+designed to execute programs compiled to the Microsoft Intermediate Language (MSIL) has a fully specified
+ABI [CLRABI]_.
+
+Vocabulary
+==========
+
+#. Program: An eBPF Program is a self-contained set of eBPF instructions that execute
+   on an eBPF processor.
+#. Program Type: Every eBPF program has an associated type. The program type defines, among other things,
+   a program's possible attach types.
+#. Attach Type: An attach type defines the set of BPF hook points to which an eBPF
+   program can attach.
+#. BPF Hook Points: Places in a BPF-enabled component (e.g., the Linux Kernel, the Windows kernel) where
+   an eBPF program may be attached.
+#. eBPF Machine Instantiation: 
+#. ABI-conforming system: A computer system that provides the binary sys- tem interface for application
+   programs described in the System V ABI [SYSVABI]_.
+#. ABI-conforming program: A program written to include only the system routines, commands, and other
+   resources included in the ABI, and a program compiled into an executable file that has the formats
+   and characteristics specified for such files in the ABI, and a program whose behavior complies with
+   the rules given in the ABI [SYSVABI]_.
+#. ABI-nonconforming program: A program which has been written to include system routines, commands, or
+   other resources not included in the ABI, or a program which has been compiled into a format different
+   from those specified in the ABI, or a program which does not behave as specified in the ABI [SYSVABI]_.
+#. Undefined Behavior: Behavior that may vary from instance to instance or may change at some time in the future.
+   Some undesirable programming practices are marked in the ABI as yielding undefined behavior [SYSVABI]_. 
+#. Unspecified Property: A property of an entity that is not explicitly included or referenced in this specification,
+   and may change at some time in the future. In general, it is not good practice to make a program depend
+   on an unspecified property [SYSVABI]_.
+
+Program Execution Environment
+=============================
+
+A loaded eBPF program is executed on an eBPF machine. That machine, physical or virtual, runs in a freestanding
+or hosted environment [#]_.
+
+eBPF Machine Freestanding Environment
+-------------------------------------
+
+
+eBPF Machine Hosted Environment
+-------------------------------
+
+A loaded eBPF program can be attached to a BPF hook point in a BPF-enabled application
+compatible with the attach type of its program type. When the BPF-enabled application's
+execution reaches a BPF hook point to which an eBPF program is attached, that program
+begins execution on the eBPF machine at its first instruction. The contents of eBPF machine's
+registers and memory at the time it starts execution are defined by the eBPF program's
+type and attach point.
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
+eBPF has 11 64-bit wide registers, `r0` - `r10`. The contents of the registers
+at the beginning of an eBPF program's execution depend on the program's type.
+
+Frame Pointer Register
+^^^^^^^^^^^^^^^^^^^^^^
+The use of a frame pointer by programs is not required. If, however, an eBPF program
+does use a frame pointer, it must be stored in register `r10`.
+
+Data Types
+----------
 
-Registers and calling convention
-================================
+Numeric Types
+^^^^^^^^^^^^^
 
-BPF has 10 general purpose registers and a read-only frame pointer register,
-all of which are 64-bits wide.
+The eBPF machine supports 32- and 64-bit signed and unsigned integers. It does 
+not support floating-point data types. All signed integers are represented in
+twos-complement format where the sign bit is stored in the most-significant
+bit.
 
-The BPF calling convention is defined as:
+Pointers
+^^^^^^^^
 
-* R0: return value from function calls, and exit value for BPF programs
+Function Calling Sequence
+=========================
+This section defines the standard function calling sequence in a way that
+accommodates exceptions, stack management, register (non)volatility, and access
+to capabilities of the hosting environment (where applicable).
+
+Functions in eBPF may define between 0 and 5 parameters. Each of the arguments in
+a function call are passed in registers.
+
+The eBPF calling convention is defined as:
+
+* R0: return value from function calls, and exit value for eBPF programs
 * R1 - R5: arguments for function calls
 * R6 - R9: callee saved registers that function calls will preserve
 * R10: read-only frame pointer to access stack
 
-R0 - R5 are scratch registers and BPF programs needs to spill/fill them if
+R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
 necessary across calls.
+
+Every function invocation proceeds as if it has exclusive access to an
+implementation-defined amount of stack space. R10 is a pointer to the byte of
+memory with the highest address in that stack space. The contents
+of a function invocation's stack space do not persist between invocations.
+
+**TODO** Discuss manufactured prologue and epilogue. Take language from the design FAQ.
+
+Execution Environment Interface
+===============================
+
+When an eBPF program executes in a hosted environment, the hosted environment may make
+available to eBPF programs certain capabilities. This section describes those capabilities
+and the mechanism for accessing them.
+
+
+Program Execution
+=================
+
+Program Return Values
+---------------------
+
+**NOTE** libbpf currently defines the return value of an ebpf program as a 32-bit unsigned integer.
+
+Program Loading and Dynamic Linking
+-----------------------------------
+This section describes the object file information and system actions that create
+running programs. Some information here applies to all systems; information specific
+to one processor resides in sections marked accordingly [SYSVABI]_.
+
+eBPF programs saved in ELF files must be loaded from storage and properly configured before
+they can be executed on an eBPF machine. 
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
+eBPF Program Types
+==================
+**NOTE** This information may end up as a subsection somewhere else.
+
+eBPF Maps
+=========
+**NOTE** This information may end up as a subsection somewhere else.
+
+System Calls
+============
+
+**TODO**
+
+C Programming Language Support
+==============================
+
+**NOTE** This section could be included in order to define the contents
+of standardized processor-specific header files that would make it easier
+for programmers to write programs.
+
+Notes
+=====
+.. [#] The eBPF machine does not need to be a physical instantiation of a processor. In fact, many instantiations of eBPF machines are virtual.
+.. [#] See the [CSTD]_ for the inspiration for this distinction.
+
+References
+==========
+
+.. [SYSVABI] System V Application Binary Interface - Edition 4.1. SCO Developer Specs. The Santa Cruz Operation. 1997. https://www.sco.com/developers/devspecs/gabi41.pdf
+.. [POWERPCABI] Developing PowerPC Embedded Application Binary Interface (EABI) Compliant Programs. PowerPC Embedded Processors Application Note. IBM. 1998. http://class.ece.iastate.edu/arun/Cpre381_Sp06/lab/labw12a/eabi_app.pdf
+.. [GOABI] Go internal ABI specification. Go Source Code. No authors. 2023. https://go.googlesource.com/go/+/refs/heads/master/src/cmd/compile/abi-internal.md
+.. [JAVAABI] The Java (r) Language Specification - Java SE 7 Edition. Gosling, James et. al. Oracle. 2013. https://docs.oracle.com/javase/specs/jls/se7/html/index.html
+.. [DALVIKABI] Dalvik Bytecode. Android Core Runtime Documentation. No authors. Google. 2022. https://source.android.com/docs/core/runtime/dalvik-bytecode
+.. [CLRABI] CLR ABI. The Book of the Runtime. No authors. Microsoft. 2023. https://github.com/dotnet/coreclr/blob/master/Documentation/botr/clr-abi.md. 
+.. [CSTD] International Standard: Programming Languages - C. ISO/IEC. 2018. https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf.
+.. [RHELABI] Red Hat Enterprise Linux 8: Application Compatibility Guide. Red Hat. 2023. https://access.redhat.com/articles/rhel8-abi-compatibility 
+
+
-- 
2.41.0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

