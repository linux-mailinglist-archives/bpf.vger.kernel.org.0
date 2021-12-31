Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2124821A1
	for <lists+bpf@lfdr.de>; Fri, 31 Dec 2021 03:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbhLaCxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Dec 2021 21:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbhLaCxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Dec 2021 21:53:50 -0500
X-Greylist: delayed 221 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Dec 2021 18:53:50 PST
Received: from mail.centromere.net (unknown [IPv6:2a00:16b0:666:7445::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72346C061574
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 18:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=centromere.net;
        s=ecclesia; t=1640919221;
        bh=NvPNU/AOKi+/2ybHIFLqAmV+GLU9agefMJvHywVi/Dw=;
        h=From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=RVukgqRIan6PSFuCBhhzkk6FEk3Y+iGiIl9S8msDLlb/24359b6W0bSEipECjDPGk
         m8ef9Myzjv+9wsTa4AtdkltB+SUILTLOSDPkEE8evISbYPblNc215F0A04AlRhxPd5
         GyuMFuIPaeKVtTgKDM2PwBnXCvdz5NeEtCfC+NMb2rAC/l49VviZDCEetlclNNeKTJ
         JvGn1oSoHQwbIHoFMkiSMHKsIsXP9aHpXVN9ZA5naFPYB+ZpuC6mqNfI4CAiJRH1Cd
         H+ZO1/yMEVtn0pBJKHuhsyutV5A9NIw+ESMqLA8XCgdOYxSjVgafflYk/ZqwKmGIJX
         9oTOZYbAB+WeuEOgsi208/0V+frabTvRRrO6BA7dOXP3d5pEAyHGL/nNCotLjPdZpq
         xnwPdi7Ef/yWeGbyQALn/I1Nx9WWVcm5oUzElPW3lKKvSTRTfDv2AX9vIqQqyj+2L3
         XiIe/TWQhtU+uqzimVKMLX40PVW0rChpUV+0kw26SyvqUIzPcZ8LH6qDC3YLX1pEHF
         VpO6j3OLOaU8MnlSgM/NBkbBJkamdyPjIlLalEpAHQekDeaIFIlkSD42Ev9r4CxKka
         F31IQyZMk7EecU4dOaVvKK2uxkBUj1Ews2cD8mPEzxA8oDEfE6XSaiC4IcwvnWB9Yn
         p8GnVv9juhlY/kXc5hefddrU=
Date:   Thu, 30 Dec 2021 21:53:38 -0500
From:   Alex <bpf@centromere.net>
To:     <bpf@vger.kernel.org>
Subject: libbpf: Memory error detected by Valgrind
Message-ID: <20211230215338.6be8cccf@poseidon.quill.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With valgrind I discovered the following in v0.6.1:

```
==923672== Memcheck, a memory error detector
==923672== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==923672== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
==923672== Command: ...
==923672==
==923672== Conditional jump or move depends on uninitialised value(s)
==923672==    at 0x46707C: strlen (in ...)
==923672==    by 0x466F4D: strdup (in ...)
==923672==    by 0x41DE90: internal_map_name (libbpf.c:1521)
==923672==    by 0x41DE90: bpf_object__init_internal_map (libbpf.c:1540)
==923672==    by 0x4200B0: bpf_object__init_global_data_maps (libbpf.c:1601)
==923672==    by 0x4266B5: bpf_object__init_maps (libbpf.c:2601)
==923672==    by 0x4266B5: __bpf_object__open.part.0 (libbpf.c:6937)
==923672==    by 0x429609: __bpf_object__open (libbpf.c:6885)
==923672==    by 0x429609: bpf_object__open_mem (libbpf.c:6999)
==923672==    by 0x4315C0: bpf_object__open_skeleton (libbpf.c:11529)
```

I believe `map_name` in `internal_map_name` of src/libbpf.c is the culprit:

char map_name[BPF_OBJ_NAME_LEN], *p;

The issue disappears when I change this line to:

char map_name[BPF_OBJ_NAME_LEN] = {}, *p;

Should I submit a patch?

--
Alex
