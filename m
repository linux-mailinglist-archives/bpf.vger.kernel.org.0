Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D935B6941
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 10:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiIMINA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 04:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIMIM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 04:12:59 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3DE01A
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 01:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYvukF98t6G21eItXufQvmut3/pENUkGXb8UuFzKdxt3ttxY05L1gUNLKj+PCnd8yhtBCWXRURCOIr5mYxvXtQUNzwcLONel3FmNERcHn9IuT+G0iMfC9fQ2rj9hORlM8QLkoHYAbc6YzNON21ygdyDAULhpqfURwxrM+e6crx15qi9zb4/tRfS8oxyN1WHAskOBNFq+0M347+1teWYTpRr4yIvMjDkITm8un/r6vAwQNY/SborZjli/ZrF9cyZQ6F2bNJAzHCQf5GdAYGqSzRt2Rme5CqNeYj1yQSkAwBwS92M/ZnF0vSDRV8LyQySvnVWrWXoHzL4tSuzc0tCEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsImr0fYz/XLylxMn6Ul+zPyiduz2PoTtChz2VybCdg=;
 b=ZLkcr3m5Hwc3rY8q6Ees5groXlH/rGdk+LSIT4fhFZ4m83/2W9BYMJPKS01a7VyRy8ec6tYLKLZzDdMxvjWk3rX+tVPV2IAAiUTi0Wm+yeu0twBPdK8m1JZlQ0YnmUEsg7ZtaXe2oVpkZ7zOjsKcbOzxK9DvAy38V7teFy2Bepz/AItuqp84GWlS1zHXsufy0dCaCGg5b1jPRy+NnSKW9EkYHW7cMlwoaGDLEgFjPtwd+0r0jxGxSCK/ruAhL3TbY633tQ1Pd91HQQG2KarME/vgCRD9AnwuhmiQ1RbCJzkbdqTnVW8I7j8JzFgSrlHijF+X8kMcTgRxlwHU+Y/IRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsImr0fYz/XLylxMn6Ul+zPyiduz2PoTtChz2VybCdg=;
 b=iiJdQOWCbcZxZw/FYN1Ye1nQ1RQ3BG1x6J0yKMGvAnuOXtdB6ruDQe/eZfKbRg2gWip8ZINMJQHo4SmpNbv5XWrB6kEC/JX/Kg3ctjZs1/E8luBrDesut/r+ftBEX6bu4kn4NiHTRO4PfaYT7eAq73r49xjBQCw3JNTZxxJASyc=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DS7PR21MB3174.namprd21.prod.outlook.com (2603:10b6:8:7a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.4; Tue, 13 Sep 2022 08:12:52 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111%7]) with mapi id 15.20.5654.004; Tue, 13 Sep 2022
 08:12:52 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     bpf <bpf@vger.kernel.org>
Subject: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Topic: ebpf-docs: draft of ISA doc updates in progress
Thread-Index: AdjEi0anVH25Go4YTCyzpO9wKsLa4gCvUITg
Date:   Tue, 13 Sep 2022 08:12:52 +0000
Message-ID: <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
In-Reply-To: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3261b8ad-57de-49b8-8197-e7a439169d92;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-09T20:32:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DS7PR21MB3174:EE_
x-ms-office365-filtering-correlation-id: c76c4d1c-5fa0-4ebe-2863-08da955fc12d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIBS1pEO21ao0CBPOWLLffzQ7NjAhx530HFX1weSobS/b1Hm1vWEOVntyay/6l0wUAbAGpn6Tq0cawlAa4iZFjjShGZYNjOzJPVETn7ftg4KldPb6QAiy+2SMfD4B0c0Jc6/0nERiAgjxy0cW75NL3v3012fVOIauUU/GiI8/u/6XvIkq1sE7IbF7R2uG3+vqLiTNON0nZd5dX744OJ28JfCeJLe42s/Bg0zuD4yK5a7rRaZZx58qz/VJkUnfjCN0aSzsxGrrZh9ogLlObyEcHYPWDarh5s8c1zn+WHfG2I3SrRub6Gu+Avvb9rViWBLKhk/4SbR2EfO8HTyV0fIvJIpKenbOhJoW2bFlqAlEOmvIaCyt8+I9QSd8UlN2UMJwXuy6mmfZxRZ9qFqD9nGDxfz95w+42E5YnAJZMqcmKlyAXp47PiBN5QsdtHVFHqPZtYzooS5Rw/23J3Ta6eG+NaeqS93VMDknMDbJPbfbmAXkLiFOBSC6+Eipvq8/9b29v74QE0QxWxZU9aCAWrK/Oqu6DNlX+if1x3bYf7vsUqMhfqymELYg6M14vmndnRtp3hsWJK/szhUXr1m2avS9FUSXtCFkFbViPn1yVmGCgp9nkE2IuxtITnbHHfcVX+GSKrM0bellBuyJrpD/ryNiZ+b62a24GIKDXqFPRzIoC9nnVBT1x5aou0uaQfh8PDaII4Eq+2f0uvmS8b5UHu/RrMSXqP76mt2iaJ+4bxJvRrEMFP57n7ZfvGkCPPbR3MxtGZerygChT7MehlUVZk7VryYH73d5eimbFGGimC4vOgMS0x2+fDV4h05dPPtraAWFv4vl04szMGxrWZ0AGMC74S2C4cQwq7iKyX7IV+q8xsKiKKmxzhtfMIh8Sl0MDvq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(76116006)(38100700002)(966005)(41300700001)(10290500003)(122000001)(66946007)(5660300002)(66446008)(15650500001)(7696005)(83380400001)(33656002)(38070700005)(55016003)(8676002)(316002)(53546011)(71200400001)(52536014)(478600001)(66476007)(2906002)(186003)(6916009)(64756008)(26005)(82950400001)(86362001)(82960400001)(66556008)(6506007)(9686003)(8990500004)(30864003)(8936002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?feyaqM2lAEvmN9RFEn0pRpUg6cNEJeJ7jZrSIPqKVEkLbVx8yxM1bsRK0e?=
 =?iso-8859-1?Q?CneLqltGU21ra9//9ffRDnuDnkI9puqW9NcO1h7hjfauxqMJnMN84kJYi7?=
 =?iso-8859-1?Q?Kc0Bdy8aN4iZSkiUU0uWe9hH710m42i7cgTWO27P3aLc/P9f9nFui4C5aJ?=
 =?iso-8859-1?Q?0EPzc6WFsQAxW6lzLvbzVNc2fCxY3mnc+mrTJK7cLMbhp/7BRhawu+g+k0?=
 =?iso-8859-1?Q?bbEgTZqu6xdIbI44tJEmLsq7YpfWtJ7uOU8UKwifFbpNJq2Q2zrOzd8uEL?=
 =?iso-8859-1?Q?T6Z+3SoZFo2Z/S1IEH89E4JheOUWI982IkR7d/kcjHqYsXuFLbna9oQzYD?=
 =?iso-8859-1?Q?2lgZoJvrib5U92QzTrqSpy6FVCes88qIT701Ttvwu2hKjbXuBYyGOOlNmE?=
 =?iso-8859-1?Q?PYOlAE6IbJBjO/arBqixMNRdkd72VFqsEuZlaAjU74b/ZZ5xruH7mKQTIt?=
 =?iso-8859-1?Q?R7Eij91PJNCgwGMEtVVE973lY9tZa/YKnnvnJLpT3hfUglcWkeLF11hMzm?=
 =?iso-8859-1?Q?HQ3NHoOXHfQBuwsfSrVY03zmKDQDkO0qjEuAPZpLHIaGsyMKHxKQHE69Bb?=
 =?iso-8859-1?Q?FipiyyUxyXxJoYu5gOBNjqVBRiuNswjmMqSfDbtk+dEf3qCumU09zCUSzT?=
 =?iso-8859-1?Q?m0SGnEyYleSFsxolyq3ok1xv4D0c24DQ2l9LYpbEyIilxtD1H34uHrmiwQ?=
 =?iso-8859-1?Q?krbpzDacpdMZZqnA/q8w1Vmm/0M1od5xWBk5K0+gwUh/Kj1YKPdNlVSzc6?=
 =?iso-8859-1?Q?FpYCAzLuogYCkQoutoqY/LQhCN/Hqwto2nteeakt+VwROzi142h+ZKZLT5?=
 =?iso-8859-1?Q?nLs1QFPx/q+s2zexNSeb53gTy0Hzf3a0s4q8lTKHJALGAvYWJfy9Ow/l5t?=
 =?iso-8859-1?Q?j/9u6wLYg/08L87zZJYkIgovyaAePDxstVcgNG1Ulu9y1FgeIBqoxQ8RDa?=
 =?iso-8859-1?Q?KbzF14pz7r+ffoagOcyQmqKFhW9SccyHMnkm5JyROL+Z2sKeGApMq1/AfS?=
 =?iso-8859-1?Q?eNkMka6RwefunDDwkdXhNFzEpR/xIaUOQ61d3fybP9ZFjujGwiX7QAjAcx?=
 =?iso-8859-1?Q?/+ZlzgaIoqRgw5XAy7JG4GGJtW6m8yEYlWYNGLrd1Bv5yHS6ESzvpXOve0?=
 =?iso-8859-1?Q?tl/oaCMnU7ZLPz5o18gg2ONnKzpQE4BxXqoF0yOHwYMaUZMGinbI1loyif?=
 =?iso-8859-1?Q?kgyQ6VhG4oQk0GL3um2rAv/DRkJNF+SVO+fltfpMva0PPZLu5v2RBjUBcr?=
 =?iso-8859-1?Q?+wJPSurJYbTzL9Xs6h5+tJYTLC0ANP167aPkwJBD9OXu96dLL+r1EoggWi?=
 =?iso-8859-1?Q?NHnUevmzqc0cTXcTjuiTuZEFB9lMlftuIuA5NDyRAF2SnvVd3hgu4AB8y5?=
 =?iso-8859-1?Q?VglZYakqZ1+fPv2i1HP1O0jsxpgmvZQ0Cway2DhsJT+MLY/wdaPlO5Fgq3?=
 =?iso-8859-1?Q?V8QE3v9prT8i/WhR8EDGNAwLxvgAPNM5FDfa8uy7/GABwVNHiwBidxpCf2?=
 =?iso-8859-1?Q?fxPwYjDR76yf3t3bVH1RyubVHgsBiGee7LImyJTyHexQk1DkNXpGUvCXYy?=
 =?iso-8859-1?Q?DKtvngy6SNiTu7CSdI1WmwPEpZle+R+FXFUn3XH+SXnwocg2moaoo+mZAp?=
 =?iso-8859-1?Q?jyBWUNwlN1oMYDtDbZhkao3EoHft9DO5Ut0+dzKsWUWzuPx2NhZHaO6w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3174
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resending since the list apparently never got the emails I sent last Friday=
...

From: Dave Thaler=20
Sent: Friday, September 9, 2022 9:36 PM
To: bpf <bpf@vger.kernel.org>
Subject: ebpf-docs: draft of ISA doc updates in progress

I've been working on ISA docs, with review by Jim Harris, Quentin Monnet, a=
nd Alan
Jowett so wanted to post this before LPC when we can discuss progress and o=
pen
questions.

A rendered draft can be viewed at:
https://github.com/dthaler/ebpf-docs/blob/update/isa/kernel.org/instruction=
-set.rst

For people who prefer github format: https://github.com/dthaler/ebpf-docs/p=
ull/4

For people who use format-patch format, see below.=A0 The instruction-set.r=
st
changes are directly diffs against the kernel.org copy mirrored
to github for rendering via the link above.

Feedback welcome on the direction so far.

Thanks,
Dave


From 9db8d5bbada4f593f52078ca329702cccf22f656 Mon Sep 17 00:00:00 2001
From: Dave Thaler mailto:dthaler@microsoft.com
Date: Mon, 29 Aug 2022 12:04:06 -0700
Subject: [PATCH] Update ISA documentation

* Add section numbers
* Add glossary formatting for fields
* Use consistent field names
* Add appendix with opcode table
* Add ISA version information
* Add text about underflow, overflow, and division by zero
* Add other text based on info in other documents

Signed-off-by: Dave Thaler mailto:dthaler@microsoft.com
---
README.md=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 27 +
isa/README.md=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 2 +
isa/kernel.org/instruction-set.rst | 765 +++++++++++++++++++++--------
3 files changed, 587 insertions(+), 207 deletions(-)
create mode 100644 README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000..715496a
--- /dev/null
+++ b/README.md
@@ -0,0 +1,27 @@
+# eBPF Standard Documentation
+
+This repository is a working draft of standard eBPF documentation
+to be published by the eBPF Foundation in PDF format.
+
+The authoritative source from which it is built is expected to be
+in the Linux kernel.org repository, but not be Linux specific.
+
+A GitHub mirror should be used, as is presently done for libbpf and
+bpftool, so that other platforms and tools can easily use it.
+As such, the documentation uses the subset of RST that GitHub
+renders correctly.
+
+The documentation can be IETF RFC style MUST/SHOULD/MAY language
+if desired.=A0 It does not currently do so.
+
+## Questions
+
+1. Any objections to the github mirror approach?
+
+2. Should we include or exclude Linux implementation notes
+=A0=A0 and Clang implementation notes?
+
+3. How do we handle the legacy packet instructions?
+
+4. How do we handle the wide instructions that reference
+=A0=A0 map fd, map indices, BTF ids, and BPF callbacks?
diff --git a/isa/README.md b/isa/README.md
index 98c49da..60cc347 100644
--- a/isa/README.md
+++ b/isa/README.md
@@ -8,6 +8,8 @@ Some documentation links include:
* https://www.kernel.org/doc/Documentation/networking/filter.txt
* https://pchaigno.github.io/bpf/2021/10/20/ebpf-instruction-sets.html
* https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html#instruction=
-level-questions
+* https://lore.kernel.org/bpf/8DA9E260-AE56-4B21-90BF-CF0049CFD04D@intel.c=
om/
+* https://github.com/iovisor/bpf-docs/pull/26/files

=A0Some implementation links include:

diff --git a/isa/kernel.org/instruction-set.rst b/isa/kernel.org/instructio=
n-set.rst
index 1b0e671..7f8ee00 100644
--- a/isa/kernel.org/instruction-set.rst
+++ b/isa/kernel.org/instruction-set.rst
@@ -1,8 +1,24 @@
+.. contents::
+.. sectnum::

=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
eBPF Instruction Set
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+The eBPF instruction set consists of eleven 64 bit registers, a program co=
unter,
+and 512 bytes of stack space.
+
+Versions
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The current Instruction Set Architecture (ISA) version, sometimes referred=
 to in other documents
+as a "CPU" version, is 3.=A0 This document also covers older versions of t=
he ISA.
+
+=A0=A0 **Note**
+
+=A0=A0 *Clang implementation*: Clang can select the eBPF ISA version using
+=A0=A0 ``-mcpu=3Dv2`` for example to select version 2.
+
Registers and calling convention
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

@@ -11,198 +27,331 @@ all of which are 64-bits wide.

=A0The eBPF calling convention is defined as:

- * R0: return value from function calls, and exit value for eBPF programs
- * R1 - R5: arguments for function calls
- * R6 - R9: callee saved registers that function calls will preserve
- * R10: read-only frame pointer to access stack
+* R0: return value from function calls, and exit value for eBPF programs
+* R1 - R5: arguments for function calls
+* R6 - R9: callee saved registers that function calls will preserve
+* R10: read-only frame pointer to access stack
+
+Registers R0 - R5 are scratch registers, meaning the BPF program needs to =
either
+spill them to the BPF stack or move them to callee saved registers if thes=
e
+arguments are to be reused across multiple function calls. Spilling means
+that the value in the register is moved to the BPF stack. The reverse oper=
ation
+of moving the variable from the BPF stack to the register is called fillin=
g.
+The reason for spilling/filling is due to the limited number of registers.

-R0 - R5 are scratch registers and eBPF programs needs to spill/fill them i=
f
-necessary across calls.
+=A0=A0 **Note**
+
+=A0=A0 *Linux implementation*: In the Linux kernel, the exit value for eBP=
F
+=A0=A0 programs is passed as a 32 bit value.
+
+Upon entering execution of an eBPF program, registers R1 - R5 initially ca=
n contain
+the input arguments for the program (similar to the argc/argv pair for a t=
ypical C program).
+The actual number of registers used, and their meaning, is defined by the =
program type;
+for example, a networking program might have an argument that includes net=
work packet data
+and/or metadata.
+
+=A0=A0 **Note**
+
+=A0=A0 *Linux implementation*: In the Linux kernel, all program types only=
 use
+=A0=A0 R1 which contains the "context", which is typically a structure con=
taining all
+=A0=A0 the inputs needed.=A0=20
=A0
=A0Instruction encoding
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+An eBPF program is a sequence of instructions.
+
eBPF has two instruction encodings:

- * the basic instruction encoding, which uses 64 bits to encode an instruc=
tion
- * the wide instruction encoding, which appends a second 64-bit immediate =
value
-=A0=A0 (imm64) after the basic instruction for a total of 128 bits.
+* the basic instruction encoding, which uses 64 bits to encode an instruct=
ion
+* the wide instruction encoding, which appends a second 64-bit immediate (=
i.e.,
+=A0 constant) value after the basic instruction for a total of 128 bits.
+
+The basic instruction encoding is as follows:

-The basic instruction encoding looks as follows:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+32 bits (MSB)=A0 16 bits=A0 4 bits=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4 bits=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8 bits (LSB)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset=A0=A0 src=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 dst=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 opcode
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- 32 bits (MSB)=A0 16 bits=A0 4 bits=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4 bits=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8 bits (LSB)
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- immediate=A0=A0=A0=A0=A0 offset=A0=A0 source register=A0 destination regi=
ster=A0 opcode
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+imm=A0=A0=A0=A0=A0=A0=A0=A0=20
+=A0 integer immediate value
+
+offset
+=A0 signed integer offset used with pointer arithmetic
+
+src
+=A0 source register number (0-10)
+
+dst
+=A0 destination register number (0-10)
+
+opcode
+=A0 operation to perform

=A0Note that most instructions do not use all of the fields.
-Unused fields shall be cleared to zero.
+Unused fields must be set to zero.
+
+As discussed below in `64-bit immediate instructions`_, some basic
+instructions denote that a 64-bit immediate value follows.=A0 Thus
+the wide instruction encoding is as follows:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+64 bits (MSB)=A0=A0=A0=A0=A0 64 bits (LSB)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+basic instruction=A0 imm64
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+where MSB and LSB mean the most significant bits and least significant bit=
s, respectively.
+
+In the remainder of this document 'src' and 'dst' refer to the values of t=
he source
+and destination registers, respectively, rather than the register number.

=A0Instruction classes
-------------------

-The three LSB bits of the 'opcode' field store the instruction class:
-
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 class=A0=A0=A0=A0=A0 value=A0 description
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 BPF_LD=A0=A0=A0=A0 0x00=A0=A0 non-standard load operations
-=A0 BPF_LDX=A0=A0=A0 0x01=A0=A0 load into register operations
-=A0 BPF_ST=A0=A0=A0=A0 0x02=A0=A0 store from immediate operations
-=A0 BPF_STX=A0=A0=A0 0x03=A0=A0 store from register operations
-=A0 BPF_ALU=A0=A0=A0 0x04=A0=A0 32-bit arithmetic operations
-=A0 BPF_JMP=A0=A0=A0 0x05=A0=A0 64-bit jump operations
-=A0 BPF_JMP32=A0 0x06=A0=A0 32-bit jump operations
-=A0 BPF_ALU64=A0 0x07=A0=A0 64-bit arithmetic operations
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The encoding of the 'opcode' field varies and can be determined from
+the three least significant bits (LSB) of the 'opcode' field which holds
+the "instruction class", as follows:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =
=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+class=A0=A0=A0=A0=A0 value=A0 description=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 version=A0 reference
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =
=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+BPF_LD=A0=A0=A0=A0 0x00=A0=A0 non-standard load operations=A0=A0=A0=A0 1=
=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+BPF_LDX=A0=A0=A0 0x01=A0=A0 load into register operations=A0=A0=A0 1=A0=A0=
=A0=A0=A0=A0=A0 `Load and store instructions`_
+BPF_ST=A0=A0=A0=A0 0x02=A0=A0 store from immediate operations=A0 1=A0=A0=
=A0=A0=A0=A0=A0 `Load and store instructions`_
+BPF_STX=A0=A0=A0 0x03=A0=A0 store from register operations=A0=A0 1=A0=A0=
=A0=A0=A0=A0=A0 `Load and store instructions`_
+BPF_ALU=A0=A0=A0 0x04=A0=A0 32-bit arithmetic operations=A0=A0=A0=A0 3=A0=
=A0=A0 =A0=A0=A0=A0`Arithmetic and jump instructions`_
+BPF_JMP=A0=A0=A0 0x05=A0=A0 64-bit jump operations=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 1=A0=A0=A0=A0=A0=A0=A0 `Arithmetic and jump instructions`_
+BPF_JMP32=A0 0x06=A0=A0 32-bit jump operations=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 3=A0=A0=A0=A0=A0=A0=A0 `Arithmetic and jump instructions`_
+BPF_ALU64=A0 0x07=A0=A0 64-bit arithmetic operations=A0=A0=A0=A0 1=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic and jump instructions`_
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =
=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+where 'version' indicates the first ISA version in which support for the v=
alue was mandatory.

=A0Arithmetic and jump instructions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

-For arithmetic and jump instructions (BPF_ALU, BPF_ALU64, BPF_JMP and
-BPF_JMP32), the 8-bit 'opcode' field is divided into three parts:
+For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JM=
P`` and
+``BPF_JMP32``), the 8-bit 'opcode' field is divided into three parts:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+4 bits (MSB)=A0=A0=A0 1 bit=A0=A0 3 bits (LSB)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+code=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 source=A0 instruction class
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 4 bits (MSB)=A0=A0=A0 1 bit=A0=A0 3 bits (LSB)
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 operation code=A0 source=A0 instruction class
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+code
+=A0 the operation code, whose meaning varies by instruction class

-The 4th bit encodes the source operand:
+source
+=A0 the source operand location, which unless otherwise specified is one o=
f:

=A0=A0=A0=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=A0=A0 source=A0 value=A0 description
=A0=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=A0 BPF_K=A0=A0 0x00=A0=A0 use 32-bit immediate as source operand
-=A0 BPF_X=A0=A0 0x08=A0=A0 use 'src_reg' register as source operand
+=A0 BPF_K=A0=A0 0x00=A0=A0 use 32-bit 'imm' value as source operand
+=A0 BPF_X=A0=A0 0x08=A0=A0 use 'src' register value as source operand
=A0=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

-The four MSB bits store the operation code.
-
+instruction class
+=A0 the instruction class (see `Instruction classes`_)

=A0Arithmetic instructions
-----------------------

-BPF_ALU uses 32-bit wide operands while BPF_ALU64 uses 64-bit wide operand=
s for
+Instruction class ``BPF_ALU`` uses 32-bit wide operands (zeroing the upper=
 32 bits
+of the destination register) while ``BPF_ALU64`` uses 64-bit wide operands=
 for
otherwise identical operations.
-The code field encodes the operation as below:

-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 code=A0=A0=A0=A0=A0 value=A0 description
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 BPF_ADD=A0 =A00x00=A0=A0 dst +=3D src
-=A0 BPF_SUB=A0=A0 0x10=A0=A0 dst -=3D src
-=A0 BPF_MUL=A0=A0 0x20=A0=A0 dst \*=3D src
-=A0 BPF_DIV=A0=A0 0x30=A0=A0 dst /=3D src
-=A0 BPF_OR=A0=A0=A0 0x40=A0=A0 dst \|=3D src
-=A0 BPF_AND=A0=A0 0x50=A0=A0 dst &=3D src
-=A0 BPF_LSH=A0=A0 0x60=A0=A0 dst <<=3D src
-=A0 BPF_RSH=A0=A0 0x70=A0=A0 dst >>=3D src
-=A0 BPF_NEG=A0=A0 0x80=A0=A0 dst =3D ~src
-=A0 BPF_MOD=A0=A0 0x90=A0=A0 dst %=3D src
-=A0 BPF_XOR=A0=A0 0xa0=A0=A0 dst ^=3D src
-=A0 BPF_MOV=A0=A0 0xb0=A0=A0 dst =3D src
-=A0 BPF_ARSH=A0 0xc0=A0=A0 sign extending shift right
-=A0 BPF_END=A0=A0 0xd0=A0=A0 byte swap operations (see separate section be=
low)
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Support for ``BPF_ALU`` is required in ISA version 3, and optional in earl=
ier
+versions.
+
+=A0=A0 **Note**
+
+=A0=A0 *Clang implementation*:
+=A0=A0 For ISA versions prior to 3, Clang v7.0 and later can enable ``BPF_=
ALU`` support with
+=A0=A0 ``-Xclang -target-feature -Xclang +alu32``.
+
+The 4-bit 'code' field encodes the operation as follows:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+code=A0=A0=A0=A0=A0 value=A0 description
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF_ADD=A0=A0 0x00=A0=A0 dst +=3D src
+BPF_SUB=A0=A0 0x10=A0=A0 dst -=3D src
+BPF_MUL=A0=A0 0x20=A0=A0 dst \*=3D src
+BPF_DIV=A0=A0 0x30=A0=A0 dst /=3D src
+BPF_OR=A0=A0=A0 0x40=A0=A0 dst \|=3D src
+BPF_AND=A0=A0 0x50=A0=A0 dst &=3D src
+BPF_LSH=A0=A0 0x60=A0=A0 dst <<=3D src
+BPF_RSH=A0=A0 0x70=A0=A0 dst >>=3D src
+BPF_NEG=A0=A0 0x80=A0=A0 dst =3D ~src
+BPF_MOD=A0=A0 0x90=A0=A0 dst %=3D src
+BPF_XOR=A0=A0 0xa0=A0=A0 dst ^=3D src
+BPF_MOV=A0=A0 0xb0=A0=A0 dst =3D src
+BPF_ARSH=A0 0xc0=A0=A0 sign extending shift right
+BPF_END=A0=A0 0xd0=A0=A0 byte swap operations (see `Byte swap instructions=
`_ below)
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Underflow and overflow are allowed during arithmetic operations,
+meaning the 64-bit or 32-bit value will wrap.
+
+``BPF_DIV`` has an implicit program exit condition as well. If
+eBPF program execution would result in division by zero,
+program execution must be gracefully aborted.
+
+Examples:

-BPF_ADD | BPF_X | BPF_ALU means::
+``BPF_ADD | BPF_X | BPF_ALU`` (0x0c) means::

-=A0 dst_reg =3D (u32) dst_reg + (u32) src_reg;
+=A0 dst =3D (uint32_t) (dst + src);

-BPF_ADD | BPF_X | BPF_ALU64 means::
+where '(uint32_t)' indicates truncation to 32 bits.

-=A0 dst_reg =3D dst_reg + src_reg
+=A0=A0 **Note**

-BPF_XOR | BPF_K | BPF_ALU means::
+=A0=A0 *Linux implementation*: In the Linux kernel, uint32_t is expressed =
as u32,
+=A0=A0 uint64_t is expressed as u64, etc.=A0 This document uses the standa=
rd C terminology
+=A0=A0 as the cross-platform specification.

-=A0 src_reg =3D (u32) src_reg ^ (u32) imm32
+``BPF_ADD | BPF_X | BPF_ALU64`` (0x0f) means::

-BPF_XOR | BPF_K | BPF_ALU64 means::
+=A0 dst =3D dst + src

-=A0 src_reg =3D src_reg ^ imm32
+``BPF_XOR | BPF_K | BPF_ALU`` (0xa4) means::
+
+=A0 src =3D (uint32_t) src ^ (uint32_t) imm
+
+``BPF_XOR | BPF_K | BPF_ALU64`` (0xa7) means::
+
+=A0 src =3D src ^ imm

=A0
=A0Byte swap instructions
-----------------------
+~~~~~~~~~~~~~~~~~~~~~~

=A0The byte swap instructions use an instruction class of ``BPF_ALU`` and a=
 4-bit
-code field of ``BPF_END``.
+'code' field of ``BPF_END``.

=A0The byte swap instructions operate on the destination register
only and do not use a separate source register or immediate value.

-The 1-bit source operand field in the opcode is used to to select what byt=
e
-order the operation convert from or to:
+Byte swap instructions use non-default semantics of the 1-bit 'source' fie=
ld in
+the 'opcode' field.=A0 Instead of indicating the source operator, it is in=
stead
+used to select what byte order the operation converts from or to:

-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 source=A0=A0=A0=A0 value=A0 description
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 BPF_TO_LE=A0 0x00=A0=A0 convert between host byte order and little end=
ian
-=A0 BPF_TO_BE=A0 0x08=A0=A0 convert between host byte order and big endian
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-The imm field encodes the width of the swap operations.=A0 The following w=
idths
-are supported: 16, 32 and 64.
-
-Examples:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+source=A0=A0=A0=A0 value=A0 description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF_TO_LE=A0 0x00=A0=A0 convert between host byte order and little endian
+BPF_TO_BE=A0 0x08=A0=A0 convert between host byte order and big endian
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-``BPF_ALU | BPF_TO_LE | BPF_END`` with imm =3D 16 means::
+=A0=A0 **Note**

-=A0 dst_reg =3D htole16(dst_reg)
+=A0=A0 *Linux implementation*:
+=A0=A0 ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_L=
E`` and
+=A0=A0 ``BPF_TO_BE`` respectively.

-``BPF_ALU | BPF_TO_BE | BPF_END`` with imm =3D 64 means::
+The 'imm' field encodes the width of the swap operations.=A0 The following=
 widths
+are supported: 16, 32 and 64. The following table summarizes the resulting
+possibilities:

-=A0 dst_reg =3D htobe64(dst_reg)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+opcode construction=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 opcode=A0=A0=A0=A0 im=
m=A0 mnemonic=A0 pseudocode
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF_END | BPF_TO_LE | BPF_ALU=A0 0xd4=A0=A0=A0=A0=A0=A0 16=A0=A0 le16 dst=
=A0 dst =3D htole16(dst)
+BPF_END | BPF_TO_LE | BPF_ALU=A0 0xd4=A0=A0=A0=A0=A0=A0 32=A0=A0 le32 dst=
=A0 dst =3D htole32(dst)
+BPF_END | BPF_TO_LE | BPF_ALU=A0 0xd4=A0=A0=A0=A0=A0=A0 64=A0=A0 le64 dst=
=A0 dst =3D htole64(dst)
+BPF_END | BPF_TO_BE | BPF_ALU=A0 0xdc=A0=A0=A0=A0=A0=A0 16=A0=A0 be16 dst=
=A0 dst =3D htobe16(dst)
+BPF_END | BPF_TO_BE | BPF_ALU=A0 0xdc=A0=A0=A0=A0=A0=A0 32=A0=A0 be32 dst=
=A0 dst =3D htobe32(dst)
+BPF_END | BPF_TO_BE | BPF_ALU=A0 0xdc=A0=A0=A0=A0=A0=A0 64=A0=A0 be64 dst=
=A0 dst =3D htobe64(dst)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and
-``BPF_TO_BE`` respectively.
+where

+* mnenomic indicates a short form that might be displayed by some tools su=
ch as disassemblers
+* 'htoleNN()' indicates converting a NN-bit value from host byte order to =
little-endian byte order
+* 'htobeNN()' indicates converting a NN-bit value from host byte order to =
big-endian byte order

=A0Jump instructions
-----------------

-BPF_JMP32 uses 32-bit wide operands while BPF_JMP uses 64-bit wide operand=
s for
+Instruction class ``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`=
` uses 64-bit wide operands for
otherwise identical operations.
-The code field encodes the operation as below:
-
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-=A0 code=A0=A0=A0=A0=A0 value=A0 description=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 notes
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-=A0 BPF_JA=A0=A0=A0 0x00=A0=A0 PC +=3D off=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 BPF_JMP only
-=A0 BPF_JEQ=A0=A0 0x10=A0=A0 PC +=3D off if dst =3D=3D src
-=A0 BPF_JGT=A0=A0 0x20=A0=A0 PC +=3D off if dst > src=A0=A0=A0=A0 unsigned
-=A0 BPF_JGE=A0=A0 0x30=A0=A0 PC +=3D off if dst >=3D src=A0=A0=A0 unsigned
-=A0 BPF_JSET=A0 0x40=A0=A0 PC +=3D off if dst & src
-=A0 BPF_JNE=A0=A0 0x50=A0=A0 PC +=3D off if dst !=3D src
-=A0 BPF_JSGT=A0 0x60=A0=A0 PC +=3D off if dst > src=A0=A0=A0=A0 signed
-=A0 BPF_JSGE=A0 0x70=A0=A0 PC +=3D off if dst >=3D src=A0=A0=A0 signed
-=A0 BPF_CALL=A0 0x80=A0=A0 function call
-=A0 BPF_EXIT=A0 0x90=A0=A0 function / program return=A0 BPF_JMP only
-=A0 BPF_JLT=A0=A0 0xa0=A0=A0 PC +=3D off if dst < src=A0=A0=A0=A0 unsigned
-=A0 BPF_JLE=A0=A0 0xb0=A0=A0 PC +=3D off if dst <=3D src=A0=A0=A0 unsigned
-=A0 BPF_JSLT=A0 0xc0=A0=A0 PC +=3D off if dst < src=A0=A0=A0=A0 signed
-=A0 BPF_JSLE=A0 0xd0=A0=A0 PC +=3D off if dst <=3D src=A0=A0=A0 signed
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-
-The eBPF program needs to store the return value into register R0 before d=
oing a
-BPF_EXIT.

+Support for ``BPF_JMP32`` is required in ISA version 3, and optional in ea=
rlier
+versions.
+
+The 4-bit 'code' field encodes the operation as below, where PC is the pro=
gram counter:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+code=A0=A0=A0=A0=A0 value=A0 description=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 version=A0 notes
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF_JA=A0=A0=A0 0x00=A0=A0 PC +=3D offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0 BPF_JMP only
+BPF_JEQ=A0=A0 0x10=A0=A0 PC +=3D offset if dst =3D=3D src=A0=A0=A0 1
+BPF_JGT=A0=A0 0x20=A0=A0 PC +=3D offset if dst > src=A0=A0=A0=A0 1=A0=A0=
=A0=A0=A0=A0=A0 unsigned
+BPF_JGE=A0=A0 0x30=A0=A0 PC +=3D offset if dst >=3D src=A0=A0=A0 1=A0=A0=
=A0=A0=A0=A0=A0 unsigned
+BPF_JSET=A0 0x40=A0=A0 PC +=3D offset if dst & src=A0=A0=A0=A0 1
+BPF_JNE=A0=A0 0x50=A0=A0 PC +=3D offset if dst !=3D src=A0=A0=A0 1
+BPF_JSGT=A0 0x60=A0=A0 PC +=3D offset if dst > src=A0=A0=A0=A0 1=A0=A0=A0=
=A0=A0=A0=A0 signed
+BPF_JSGE=A0 0x70=A0=A0 PC +=3D offset if dst >=3D src=A0=A0=A0 1=A0=A0=A0=
=A0=A0=A0=A0 signed
+BPF_CALL=A0 0x80=A0=A0 call function imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 1=A0=A0=A0=A0=A0=A0=A0 see `Helper functions`_
+BPF_EXIT=A0 0x90=A0=A0 function / program return=A0=A0=A0=A0 1=A0=A0=A0=A0=
=A0=A0=A0 BPF_JMP only
+BPF_JLT=A0=A0 0xa0=A0=A0 PC +=3D offset if dst < src=A0=A0=A0=A0 2=A0=A0=
=A0=A0=A0=A0=A0 unsigned
+BPF_JLE=A0=A0 0xb0=A0=A0 PC +=3D offset if dst <=3D src=A0=A0=A0 2=A0=A0=
=A0=A0=A0=A0=A0 unsigned
+BPF_JSLT=A0 0xc0=A0=A0 PC +=3D offset if dst < src=A0=A0=A0=A0 2=A0=A0=A0=
=A0=A0=A0=A0 signed
+BPF_JSLE=A0 0xd0=A0=A0 PC +=3D offset if dst <=3D src=A0=A0=A0 2=A0=A0=A0=
=A0=A0=A0=A0 signed
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+where 'version' indicates the first ISA version in which the value was sup=
ported.
+
+Helper functions
+~~~~~~~~~~~~~~~~
+Helper functions are a concept whereby BPF programs can call into
+set of function calls exposed by the eBPF runtime.=A0 Each helper
+function is identified by an integer used in a ``BPF_CALL`` instruction.
+The available helper functions may differ for each eBPF program type.
+
+Conceptually, each helper function is implemented with a commonly shared f=
unction
+signature defined as:
+
+=A0 uint64_t function(uint64_t r1, uint64_t r2, uint64_t r3, uint64_t r4, =
uint64_t r5)
+
+In actuality, each helper function is defined as taking between 0 and 5 ar=
guments,
+with the remaining registers being ignored.=A0 The definition of a helper =
function
+is responsible for specifying the type (e.g., integer, pointer, etc.) of t=
he value returned,
+the number of arguments, and the type of each argument.

=A0Load and store instructions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

-For load and store instructions (BPF_LD, BPF_LDX, BPF_ST and BPF_STX), the
+For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and =
``BPF_STX``), the
8-bit 'opcode' field is divided as:

-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 3 bits (MSB)=A0 2 bits=A0 3 bits (LSB)
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 mode=A0=A0=A0=A0=A0=A0=A0=A0=A0 size=A0=A0=A0 instruction class
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+3 bits (MSB)=A0 2 bits=A0 3 bits (LSB)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+mode=A0=A0=A0=A0=A0=A0=A0=A0=A0 size=A0=A0=A0 instruction class
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-The size modifier is one of:
+mode
+=A0 one of:
+
+=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=A0 mode modifier=A0 value=A0 description=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reference
+=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=A0 BPF_IMM=A0=A0=A0=A0=A0=A0=A0 0x00=A0=A0 64-bit immediate instructions=
=A0=A0=A0=A0=A0=A0=A0=A0 `64-bit immediate instructions`_
+=A0 BPF_ABS=A0=A0=A0=A0=A0=A0=A0 0x20=A0=A0 legacy BPF packet access (abso=
lute)=A0=A0 `Legacy BPF Packet access instructions`_
+=A0 BPF_IND=A0=A0=A0=A0=A0=A0=A0 0x40=A0=A0 legacy BPF packet access (indi=
rect)=A0=A0 `Legacy BPF Packet access instructions`_
+=A0 BPF_MEM=A0=A0=A0=A0=A0=A0=A0 0x60=A0=A0 regular load and store operati=
ons=A0=A0=A0=A0 `Regular load and store operations`_
+=A0 BPF_ATOMIC=A0=A0=A0=A0 0xc0=A0=A0 atomic operations=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+size
+=A0 one of:

=A0=A0=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=A0=A0 size modifier=A0 value=A0 description
@@ -213,18 +362,8 @@ The size modifier is one of:
=A0=A0 BPF_DW=A0=A0=A0=A0=A0=A0=A0=A0 0x18=A0=A0 double word (8 bytes)
=A0=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-The mode modifier is one of:
-
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 mode modifier=A0 value=A0 description
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 BPF_IMM=A0=A0=A0=A0=A0=A0=A0 0x00=A0=A0 64-bit immediate instructions
-=A0 BPF_ABS=A0=A0=A0=A0=A0=A0=A0 0x20=A0=A0 legacy BPF packet access (abso=
lute)
-=A0 BPF_IND=A0=A0=A0=A0=A0=A0=A0 0x40=A0=A0 legacy BPF packet access (indi=
rect)
-=A0 BPF_MEM=A0=A0=A0=A0=A0=A0=A0 0x60=A0=A0 regular load and store operati=
ons
-=A0 BPF_ATOMIC=A0=A0=A0=A0 0xc0=A0=A0 atomic operations
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
+instruction class
+=A0 the instruction class (see `Instruction classes`_)

=A0Regular load and store operations
---------------------------------
@@ -232,19 +371,22 @@ Regular load and store operations
The ``BPF_MEM`` mode modifier is used to encode regular load and store
instructions that transfer data between a register and memory.

-``BPF_MEM | <size> | BPF_STX`` means::
-
-=A0 *(size *) (dst_reg + off) =3D src_reg
-
-``BPF_MEM | <size> | BPF_ST`` means::
-
-=A0 *(size *) (dst_reg + off) =3D imm32
-
-``BPF_MEM | <size> | BPF_LDX`` means::
-
-=A0 dst_reg =3D *(size *) (src_reg + off)
-
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+opcode construction=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 opcode=A0=A0=A0=A0 ps=
eudocode
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+BPF_MEM | BPF_B | BPF_LDX=A0=A0=A0=A0=A0 0x71=A0=A0=A0=A0=A0=A0 dst =3D *(=
uint8_t *) (src + offset)=A0=20
+BPF_MEM | BPF_H | BPF_LDX=A0=A0=A0=A0=A0 0x69=A0=A0=A0=A0=A0=A0 dst =3D *(=
uint16_t *) (src + offset)
+BPF_MEM | BPF_W | BPF_LDX=A0=A0=A0=A0=A0 0x61=A0=A0=A0=A0=A0=A0 dst =3D *(=
uint32_t *) (src + offset)
+BPF_MEM | BPF_DW | BPF_LDX=A0=A0=A0=A0 0x79=A0=A0=A0=A0=A0=A0 dst =3D *(ui=
nt64_t *) (src + offset)
+BPF_MEM | BPF_B | BPF_ST=A0=A0=A0=A0=A0=A0 0x72=A0=A0=A0=A0=A0=A0 *(uint8_=
t *) (dst + offset) =3D imm
+BPF_MEM | BPF_H | BPF_ST=A0=A0=A0=A0=A0=A0 0x6a=A0=A0=A0=A0=A0=A0 *(uint16=
_t *) (dst + offset) =3D imm
+BPF_MEM | BPF_W | BPF_ST=A0=A0=A0=A0=A0=A0 0x62=A0=A0=A0=A0=A0=A0 *(uint32=
_t *) (dst + offset) =3D imm
+BPF_MEM | BPF_DW | BPF_ST=A0=A0=A0=A0=A0 0x7a=A0=A0=A0=A0=A0=A0 *(uint64_t=
 *) (dst + offset) =3D imm
+BPF_MEM | BPF_B | BPF_STX=A0=A0=A0=A0=A0 0x73=A0=A0=A0=A0=A0=A0 *(uint8_t =
*) (dst + offset) =3D src
+BPF_MEM | BPF_H | BPF_STX=A0=A0=A0=A0=A0 0x6b=A0=A0=A0=A0=A0=A0 *(uint16_t=
 *) (dst + offset) =3D src
+BPF_MEM | BPF_W | BPF_STX=A0=A0=A0=A0=A0 0x63=A0=A0=A0=A0=A0=A0 *(uint32_t=
 *) (dst + offset) =3D src
+BPF_MEM | BPF_DW | BPF_STX=A0=A0=A0=A0 0x7b=A0=A0=A0=A0=A0=A0 *(uint64_t *=
) (dst + offset) =3D src
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

=A0Atomic operations
-----------------
@@ -256,76 +398,83 @@ by other eBPF programs or means outside of this speci=
fication.
All atomic operations supported by eBPF are encoded as store operations
that use the ``BPF_ATOMIC`` mode modifier as follows:

-=A0 * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
-=A0 * ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
-=A0 * 8-bit and 16-bit wide atomic operations are not supported.
+* ``BPF_ATOMIC | BPF_W | BPF_STX`` (0xc3) for 32-bit operations
+* ``BPF_ATOMIC | BPF_DW | BPF_STX`` (0xdb) for 64-bit operations
+
+Note that 8-bit (``BPF_B``) and 16-bit (``BPF_H``) wide atomic operations =
are not supported,
+nor is ``BPF_ATOMIC | <size> | BPF_ST``.

-The imm field is used to encode the actual atomic operation.
+The 'imm' field is used to encode the actual atomic operation.
Simple atomic operation use a subset of the values defined to encode
-arithmetic operations in the imm field to encode the atomic operation:
+arithmetic operations in the 'imm' field to encode the atomic operation:

-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-=A0 imm=A0=A0=A0=A0=A0=A0 value=A0 description
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-=A0 BPF_ADD=A0=A0 0x00=A0=A0 atomic add
-=A0 BPF_OR=A0=A0=A0 0x40=A0=A0 atomic or
-=A0 BPF_AND=A0=A0 0x50=A0=A0 atomic and
-=A0 BPF_XOR=A0=A0 0xa0=A0=A0 atomic xor
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D
+imm=A0=A0=A0=A0=A0=A0 value=A0 description=A0 version
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D
+BPF_ADD=A0=A0 0x00=A0=A0 atomic add=A0=A0 1
+BPF_OR=A0=A0=A0 0x40=A0=A0 atomic or=A0=A0=A0 3
+BPF_AND=A0=A0 0x50=A0=A0 atomic and=A0=A0 3
+BPF_XOR=A0=A0 0xa0=A0=A0 atomic xor=A0=A0 3
+=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D

+where 'version' indicates the first ISA version in which the value was sup=
ported.

-``BPF_ATOMIC | BPF_W=A0 | BPF_STX`` with imm =3D BPF_ADD means::
+``BPF_ATOMIC | BPF_W=A0 | BPF_STX`` (0xc3) with 'imm' =3D BPF_ADD means::

-=A0 *(u32 *)(dst_reg + off16) +=3D src_reg
+=A0 *(uint32_t *)(dst + offset) +=3D src

-``BPF_ATOMIC | BPF_DW | BPF_STX`` with imm =3D BPF ADD means::
+``BPF_ATOMIC | BPF_DW | BPF_STX`` (0xdb) with 'imm' =3D BPF ADD means::

-=A0 *(u64 *)(dst_reg + off16) +=3D src_reg
+=A0 *(uint64_t *)(dst + offset) +=3D src

-``BPF_XADD`` is a deprecated name for ``BPF_ATOMIC | BPF_ADD``.
+``BPF_XADD`` appeared in version 1, but is now considered to be a deprecat=
ed alias
+for ``BPF_ATOMIC | BPF_ADD``.

-In addition to the simple atomic operations, there also is a modifier and
+In addition to the simple atomic operations above, there also is a modifie=
r and
two complex atomic operations:

-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 imm=A0=A0=A0=A0=A0=A0=A0=A0=A0 value=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 description
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=A0 BPF_FETCH=A0=A0=A0 0x01=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 modifie=
r: return old value
-=A0 BPF_XCHG=A0=A0=A0=A0 0xe0 | BPF_FETCH=A0 atomic exchange
-=A0 BPF_CMPXCHG=A0 0xf0 | BPF_FETCH=A0 atomic compare and exchange
-=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D
+imm=A0=A0=A0=A0=A0=A0=A0=A0=A0 value=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d=
escription=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 version
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D
+BPF_FETCH=A0=A0=A0 0x01=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 modifier: r=
eturn old value=A0=A0 3
+BPF_XCHG=A0=A0=A0=A0 0xe0 | BPF_FETCH=A0 atomic exchange=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 3
+BPF_CMPXCHG=A0 0xf0 | BPF_FETCH=A0 atomic compare and exchange=A0 3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D

=A0The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
always set for the complex atomic operations.=A0 If the ``BPF_FETCH`` flag
-is set, then the operation also overwrites ``src_reg`` with the value that
+is set, then the operation also overwrites ``src`` with the value that
was in memory before it was modified.

-The ``BPF_XCHG`` operation atomically exchanges ``src_reg`` with the value
-addressed by ``dst_reg + off``.
+The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
+addressed by ``dst + offset``.

=A0The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
-``dst_reg + off`` with ``R0``. If they match, the value addressed by
-``dst_reg + off`` is replaced with ``src_reg``. In either case, the
-value that was at ``dst_reg + off`` before the operation is zero-extended
+``dst + offset`` with ``R0``. If they match, the value addressed by
+``dst + offset`` is replaced with ``src``. In either case, the
+value that was at ``dst + offset`` before the operation is zero-extended
and loaded back to ``R0``.

-Clang can generate atomic instructions by default when ``-mcpu=3Dv3`` is
-enabled. If a lower version for ``-mcpu`` is set, the only atomic instruct=
ion
-Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to =
enable
-the atomics features, while keeping a lower ``-mcpu`` version, you can use
-``-Xclang -target-feature -Xclang +alu32``.
+=A0=A0 **Note**
+
+=A0=A0 *Clang implementation*:
+=A0=A0 Clang can generate atomic instructions by default when ``-mcpu=3Dv3=
`` is
+=A0=A0 enabled. If a lower version for ``-mcpu`` is set, the only atomic i=
nstruction
+=A0=A0 Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you n=
eed to enable
+=A0=A0 the atomics features, while keeping a lower ``-mcpu`` version, you =
can use
+=A0=A0 ``-Xclang -target-feature -Xclang +alu32``.

=A064-bit immediate instructions
-----------------------------

-Instructions with the ``BPF_IMM`` mode modifier use the wide instruction
+Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
encoding for an extra imm64 value.

=A0There is currently only one such instruction.

-``BPF_LD | BPF_DW | BPF_IMM`` means::
+``BPF_IMM | BPF_DW | BPF_LD`` (0x18) means::

-=A0 dst_reg =3D imm64
+=A0 dst =3D imm64

=A0
=A0Legacy BPF Packet access instructions
@@ -333,34 +482,236 @@ Legacy BPF Packet access instructions

=A0eBPF has special instructions for access to packet data that have been
carried over from classic BPF to retain the performance of legacy socket
-filters running in the eBPF interpreter.
+filters running in an eBPF interpreter.

=A0The instructions come in two forms: ``BPF_ABS | <size> | BPF_LD`` and
``BPF_IND | <size> | BPF_LD``.

=A0These instructions are used to access packet data and can only be used w=
hen
-the program context is a pointer to networking packet.=A0 ``BPF_ABS``
+the program context contains a pointer to a networking packet.=A0 ``BPF_AB=
S``
accesses packet data at an absolute offset specified by the immediate data
and ``BPF_IND`` access packet data at an offset that includes the value of
a register in addition to the immediate data.

=A0These instructions have seven implicit operands:

- * Register R6 is an implicit input that must contain pointer to a
-=A0=A0 struct sk_buff.
- * Register R0 is an implicit output which contains the data fetched from
-=A0=A0 the packet.
- * Registers R1-R5 are scratch registers that are clobbered after a call t=
o
-=A0=A0 ``BPF_ABS | BPF_LD`` or ``BPF_IND | BPF_LD`` instructions.
-
-These instructions have an implicit program exit condition as well. When a=
n
-eBPF program is trying to access the data beyond the packet boundary, the
-program execution will be aborted.
-
-``BPF_ABS | BPF_W | BPF_LD`` means::
-
-=A0 R0 =3D ntohl(*(u32 *) (((struct sk_buff *) R6)->data + imm32))
-
-``BPF_IND | BPF_W | BPF_LD`` means::
-
-=A0 R0 =3D ntohl(*(u32 *) (((struct sk_buff *) R6)->data + src_reg + imm32=
))
+* Register R6 is an implicit input that must contain a pointer to a
+=A0 context structure with a packet data pointer.
+* Register R0 is an implicit output which contains the data fetched from
+=A0 the packet.
+* Registers R1-R5 are scratch registers that are clobbered by the
+=A0 instruction.
+
+=A0=A0 **Note**
+
+=A0=A0 *Linux implementation*: In Linux, R6 references a struct sk_buff.
+
+These instructions have an implicit program exit condition as well. If an
+eBPF program attempts access data beyond the packet boundary, the
+program execution must be gracefully aborted.
+
+``BPF_ABS | BPF_W | BPF_LD`` (0x20) means::
+
+=A0 R0 =3D ntohl(*(uint32_t *) (R6->data + imm))
+
+where ``ntohl()`` converts a 32-bit value from network byte order to host =
byte order.
+
+``BPF_IND | BPF_W | BPF_LD`` (0x40) means::
+
+=A0 R0 =3D ntohl(*(uint32_t *) (R6->data + src + imm))
+
+Appendix
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+For reference, the following table lists opcodes in order by value.
+
+=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+opcode=A0 imm=A0=A0 description=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 reference=20
+=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+0x04=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst + imm)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x05=A0=A0=A0 0x00=A0 goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 `Jump instructions`_
+0x07=A0=A0=A0 any=A0 =A0dst +=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0x0c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst + src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x0f=A0=A0=A0 0x00=A0 dst +=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x14=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst - imm)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x15=A0=A0=A0 any=A0=A0 if dst =3D=3D imm goto +offset=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instruct=
ions`_
+0x16=A0=A0=A0 any=A0=A0 if (uint32_t)dst =3D=3D imm goto +offset=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0`Jump instructions`_
+0x17=A0=A0=A0 any=A0=A0 dst -=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0x18=A0=A0=A0 any=A0=A0 dst =3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x1c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst - src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x1d=A0=A0=A0 0x00=A0 if dst =3D=3D src goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instruction=
s`_
+0x1e=A0=A0=A0 0x00=A0 if (uint32_t)dst =3D=3D (uint32_t)src goto +offset=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x1f=A0=A0=A0 0x00=A0 dst -=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x20=A0=A0=A0 any=A0=A0 dst =3D ntohl(\*(uint32_t \*)(R6->data + imm))=A0=
=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x24=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst \* imm)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x25=A0=A0=A0 any=A0=A0 if dst > imm goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instruction=
s`_
+0x26=A0=A0=A0 any=A0=A0 if (uint32_t)dst > imm goto +offset=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x27=A0=A0=A0 any=A0=A0 dst \*=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0`Arithmetic instructions`_
+0x28=A0=A0=A0 any=A0=A0 dst =3D ntohs(\*(uint16_t \*)(R6->data + imm))=A0=
=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x2c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst \* src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruction=
s`_
+0x2d=A0=A0=A0 0x00=A0 if dst > src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x2e=A0=A0=A0 0x00=A0 if (uint32_t)dst > (uint32_t)src goto +offset=A0=A0=
=A0=A0=A0=A0=A0 `Jump instructions`_
+0x2f=A0=A0=A0 0x00=A0 dst \*=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 `Arithmetic instructions`_
+0x30=A0=A0=A0 any=A0=A0 dst =3D (\*(uint8_t \*)(R6->data + imm))=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x34=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst / imm)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0`Arithmetic instruct=
ions`_
+0x35=A0=A0=A0 any=A0=A0 if dst >=3D imm goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instruction=
s`_
+0x36=A0=A0=A0 any=A0=A0 if (uint32_t)dst >=3D imm goto +offset=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x37=A0=A0=A0 any=A0=A0 dst /=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0`Arithmetic instructions`_
+0x38=A0=A0=A0 any=A0=A0 dst =3D ntohll(\*(uint64_t \*)(R6->data + imm))=A0=
=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x3c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst / src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x3d=A0=A0=A0 0x00=A0 if dst >=3D src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x3e=A0=A0=A0 0x00=A0 if (uint32_t)dst >=3D (uint32_t)src goto +offset=A0=
=A0=A0=A0=A0=A0 `Jump instructions`_
+0x3f=A0=A0=A0 0x00=A0 dst /=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x40=A0=A0=A0 any=A0=A0 dst =3D ntohl(\*(uint32_t \*)(R6->data + src + imm=
))=A0=A0 `Load and store instructions`_
+0x44=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst \| imm)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x45=A0=A0=A0 any=A0=A0 if dst & imm goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0`Jump instruction=
s`_
+0x46=A0=A0=A0 any=A0=A0 if (uint32_t)dst & imm goto +offset=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x47=A0=A0=A0 any=A0=A0 dst \|=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x48=A0=A0=A0 any=A0=A0 dst =3D ntohs(\*(uint16_t \*)(R6->data + src + imm=
))=A0=A0 `Load and store instructions`_
+0x4c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst \| src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruction=
s`_
+0x4d=A0=A0=A0 0x00=A0 if dst & src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x4e=A0=A0=A0 0x00=A0 if (uint32_t)dst & (uint32_t)src goto +offset=A0=A0=
=A0=A0=A0=A0=A0 `Jump instructions`_
+0x4f=A0=A0=A0 0x00=A0 dst \|=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 `Arithmetic instructions`_
+0x50=A0=A0=A0 any=A0=A0 dst =3D \*(uint8_t \*)(R6->data + src + imm))=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x54=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst & imm)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x55=A0=A0=A0 any=A0=A0 if dst !=3D imm goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instruction=
s`_
+0x56=A0=A0=A0 any=A0=A0 if (uint32_t)dst !=3D imm goto +offset=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0`Jump instructions`_
+0x57=A0=A0=A0 any=A0=A0 dst &=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0x58=A0=A0=A0 any=A0=A0 dst =3D ntohll(\*(uint64_t \*)(R6->data + src + im=
m))=A0 `Load and store instructions`_
+0x5c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst & src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x5d=A0=A0=A0 0x00=A0 if dst !=3D src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x5e=A0=A0=A0 0x00=A0 if (uint32_t)dst !=3D (uint32_t)src goto +offset=A0=
=A0=A0=A0=A0=A0 `Jump instructions`_
+0x5f=A0=A0=A0 0x00=A0 dst &=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x61=A0=A0=A0 0x00=A0 dst =3D \*(uint32_t \*)(src + offset)=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x62=A0=A0=A0 any=A0=A0 \*(uint32_t \*)(dst + offset) =3D imm=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x63=A0=A0=A0 0x00=A0 \*(uint32_t \*)(dst + offset) =3D src=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x64=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst << imm)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x65=A0=A0=A0 any=A0=A0 if dst s> imm goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x66=A0=A0=A0 any=A0=A0 if (int32_t)dst s> (int32_t)imm goto +offset=A0=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x67=A0=A0=A0 any=A0 =A0dst <<=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x69=A0=A0=A0 0x00=A0 dst =3D \*(uint16_t \*)(src + offset)=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x6a=A0=A0=A0 any=A0=A0 \*(uint16_t \*)(dst + offset) =3D imm=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x6b=A0=A0=A0 0x00=A0 \*(uint16_t \*)(dst + offset) =3D src=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x6c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst << src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruction=
s`_
+0x6d=A0=A0=A0 0x00=A0 if dst s> src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x6e=A0=A0=A0 0x00=A0 if (int32_t)dst s> (int32_t)src goto +offset=A0=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x6f=A0=A0=A0 0x00=A0 dst <<=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 `Arithmetic instructions`_
+0x71=A0=A0=A0 0x00=A0 dst =3D \*(uint8_t \*)(src + offset)=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x72=A0=A0=A0 any=A0=A0 \*(uint8_t \*)(dst + offset) =3D imm=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x73=A0=A0=A0 0x00=A0 \*(uint8_t \*)(dst + offset) =3D src=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x74=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst >> imm)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x75=A0=A0=A0 any=A0=A0 if dst s>=3D imm goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x76=A0=A0=A0 any=A0=A0 if (int32_t)dst s>=3D (int32_t)imm goto +offset=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x77=A0=A0=A0 any=A0=A0 dst >>=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x79=A0=A0=A0 0x00=A0 dst =3D \*(uint64_t \*)(src + offset)=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x7a=A0=A0=A0 any=A0=A0 \*(uint64_t \*)(dst + offset) =3D imm=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x7b=A0=A0=A0 0x00=A0 \*(uint64_t \*)(dst + offset) =3D src=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Load and store instructions`_
+0x7c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst >> src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruction=
s`_
+0x7d=A0=A0=A0 0x00=A0 if dst s>=3D src goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x7e=A0=A0=A0 0x00=A0 if (int32_t)dst s>=3D (int32_t)src goto +offset=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x7f=A0=A0=A0 0x00=A0 dst >>=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 `Arithmetic instructions`_
+0x84=A0=A0=A0 0x00=A0 dst =3D (uint32_t)-dst=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithme=
tic instructions`_
+0x85=A0=A0=A0 any=A0=A0 call imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Jump instructions`_
+0x87=A0=A0=A0 0x00=A0 dst =3D -dst=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0x94=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst % imm)=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0`Arithmetic instru=
ctions`_
+0x95=A0=A0=A0 0x00=A0 return=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0x97=A0=A0=A0 any=A0=A0 dst %=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0x9c=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst % src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0x9f=A0=A0=A0 0x00=A0 dst %=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0xa4=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst ^ imm)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0xa5=A0=A0=A0 any=A0=A0 if dst < imm goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instruction=
s`_
+0xa6=A0=A0=A0 any=A0=A0 if (uint32_t)dst < imm goto +offset=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xa7=A0=A0=A0 any=A0=A0 dst ^=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0xac=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst ^ src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruct=
ions`_
+0xad=A0=A0=A0 0x00=A0 if dst < src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xae=A0=A0=A0 0x00=A0 if (uint32_t)dst < (uint32_t)src goto +offset=A0=A0=
=A0=A0=A0=A0=A0 `Jump instructions`_
+0xaf=A0=A0=A0 0x00=A0 dst ^=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 `Arithmetic instructions`_
+0xb4=A0=A0=A0 any=A0=A0 dst =3D (uint32_t) imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arit=
hmetic instructions`_
+0xb5=A0=A0=A0 any=A0=A0 if dst <=3D imm goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instruction=
s`_
+0xa6=A0=A0=A0 any=A0=A0 if (uint32_t)dst <=3D imm goto +offset=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xb7=A0=A0=A0 any=A0=A0 dst =3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0xbc=A0=A0=A0 0x00=A0 dst =3D (uint32_t) src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithme=
tic instructions`_
+0xbd=A0=A0=A0 0x00=A0 if dst <=3D src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xbe=A0=A0=A0 0x00=A0 if (uint32_t)dst <=3D (uint32_t)src goto +offset=A0=
=A0=A0=A0=A0=A0 `Jump instructions`_
+0xbf=A0=A0=A0 0x00=A0 dst =3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0xc3=A0=A0=A0 0x00=A0 lock \*(uint32_t \*)(dst + offset) +=3D src=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xc3=A0=A0=A0 0x01=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0`Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint32_t *)(dst + of=
fset) +=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D *(uint32_t *)(=
dst + offset)
+0xc3=A0=A0=A0 0x40=A0 \*(uint32_t \*)(dst + offset) \|=3D src=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xc3=A0=A0=A0 0x41=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint32_t *)(dst + of=
fset) |=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D *(uint32_t *)(=
dst + offset)
+0xc3=A0=A0=A0 0x50=A0 \*(uint32_t \*)(dst + offset) &=3D src=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xc3=A0=A0=A0 0x51=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint32_t *)(dst + of=
fset) &=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D *(uint32_t *)(=
dst + offset)
+0xc3=A0=A0=A0 0xa0=A0 \*(uint32_t \*)(dst + offset) ^=3D src=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xc3=A0=A0=A0 0xa1=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0*(uint32_t *)(dst + of=
fset) ^=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D *(uint32_t *)(=
dst + offset)
+0xc3=A0=A0=A0 0xe1=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 temp =3D *(uint32_t *)=
(dst + offset)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0*(uint32_t *)(dst + of=
fset) =3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D temp
+0xc3=A0=A0=A0 0xf1=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 temp =3D *(uint32_t *)=
(dst + offset)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if *(uint32_t)(dst + o=
ffset) =3D=3D R0
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint32_t)(d=
st + offset) =3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R0 =3D temp
+0xc4=A0=A0=A0 any=A0=A0 dst =3D (uint32_t)(dst s>> imm)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instruction=
s`_
+0xc5=A0=A0=A0 any=A0=A0 if dst s< imm goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xc6=A0=A0=A0 any=A0=A0 if (int32_t)dst s< (int32_t)imm goto +offset=A0=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xc7=A0=A0=A0 any=A0=A0 dst s>>=3D imm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 `Arithmetic instructions`_
+0xcc=A0=A0=A0 0x00=A0 dst =3D (uint32_t)(dst s>> src)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Arithmetic instructions`_
+0xcd=A0=A0=A0 0x00=A0 if dst s< src goto +offset=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xce=A0=A0=A0 0x00=A0 if (int32_t)dst s< (int32_t)src goto +offset=A0=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xcf=A0=A0=A0 0x00=A0 dst s>>=3D src=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 `Arithmetic instructions`_
+0xd4=A0=A0=A0 0x10=A0 dst =3D htole16(dst)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `B=
yte swap instructions`_
+0xd4=A0=A0=A0 0x20=A0 dst =3D htole32(dst)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `B=
yte swap instructions`_
+0xd4=A0=A0=A0 0x40=A0 dst =3D htole64(dst)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `B=
yte swap instructions`_
+0xd5=A0=A0=A0 any=A0=A0 if dst s<=3D imm goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xd6=A0=A0=A0 any=A0=A0 if (int32_t)dst s<=3D (int32_t)imm goto +offset=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xc3=A0=A0=A0 0x00=A0 lock \*(uint64_t \*)(dst + offset) +=3D src=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xdb=A0=A0=A0 0x01=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint64_t *)(dst + of=
fset) +=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D *(uint64_t *)(=
dst + offset)
+0xdb=A0=A0=A0 0x40=A0 \*(uint64_t \*)(dst + offset) \|=3D src=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xdb=A0=A0=A0 0x41=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0=A0=A0=A0=A0=A0=A0`Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint64_t *)(dst + of=
fset) |=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lock src =3D *(uint64_=
t *)(dst + offset)
+0xdb=A0=A0=A0 0x50=A0 \*(uint64_t \*)(dst + offset) &=3D src=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xdb=A0=A0=A0 0x51=A0 lock::=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0`Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint64_t *)(dst + of=
fset) &=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D *(uint64_t *)(=
dst + offset)
+0xdb=A0=A0=A0 0xa0=A0 \*(uint64_t \*)(dst + offset) ^=3D src=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+0xdb=A0=A0=A0 0xa1=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint64_t *)(dst + of=
fset) ^=3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src =3D *(uint64_t *)(=
dst + offset)
+0xdb=A0=A0=A0 0xe1=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 temp =3D *(uint64_t *)=
(dst + offset)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint64_t *)(dst + of=
fset) =3D src
+=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0src =3D temp
+0xdb=A0=A0=A0 0xf1=A0 lock::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 `Atomic operations`_
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 temp =3D *(uint64_t *)=
(dst + offset)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if *(uint64_t)(dst + o=
ffset) =3D=3D R0
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(uint64_t)(d=
st + offset) =3D src
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R0 =3D temp
+0xdc=A0=A0=A0 0x10=A0 dst =3D htobe16(dst)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `B=
yte swap instructions`_
+0xdc=A0=A0=A0 0x20=A0 dst =3D htobe32(dst)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `B=
yte swap instructions`_
+0xdc=A0=A0=A0 0x40=A0 dst =3D htobe64(dst)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `B=
yte swap instructions`_
+0xdd=A0=A0=A0 0x00=A0 if dst s<=3D src goto +offset=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+0xde=A0=A0=A0 0x00=A0 if (int32_t)dst s<=3D (int32_t)src goto +offset=A0=
=A0=A0=A0=A0=A0=A0 `Jump instructions`_
+=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
--=20
2.32.0.windows.1

