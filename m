Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C503C4D3615
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiCIRAK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 9 Mar 2022 12:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiCIRAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 12:00:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4D1AF8ED;
        Wed,  9 Mar 2022 08:47:10 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KDJ2m3HZyz67wwW;
        Thu, 10 Mar 2022 00:45:04 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 17:46:27 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.021;
 Wed, 9 Mar 2022 17:46:27 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] DIGLIM eBPF
Thread-Topic: [LSF/MM/BPF TOPIC] DIGLIM eBPF
Thread-Index: AdgzyU0J69ucohptSrqMF06VRSG1Dw==
Date:   Wed, 9 Mar 2022 16:46:27 +0000
Message-ID: <4d6932e96d774227b42721d9f645ba51@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear PC

I would like to propose a topic for the upcoming LSF/MM/BPF
summit in May:

DIGLIM eBPF: secure boot at application level with minimal changes to distros

The recent addition in the kernel of the bpf LSM made it
much easier to propose new LSMs targeting a specific
use case, without requiring modification of existing LSMs
in the security subsystem.

Integrity Measurement Architecture (IMA) and Extended
Verification Module (EVM) have become the de-facto
standard choice for providing kernel-based integrity
services.

However, while IMA and EVM operate at file granularity,
requiring each file to be signed to pass appraisal, Digest
Lists Integrity Module (DIGLIM) takes a different approach.
It builds a pool of reference values for file/metadata digests
and grants access to a file if the calculated digest is found
in the pool.

The main advantage of this approach is that it is not
constrained by a specific data format, as the pool can
be built from any data format, as long as the corresponding
parser is supported. DIGLIM can take reference values
from unmodified Linux distributions to make its security
decisions.

An alternative of supporting the new approach in IMA,
which would be still possible, has been to rewrite DIGLIM
as an eBPF program, to operate in a similar way as IMA
does.

Although it has yet to be seen if the performance of the
eBPF implementation matches the one aiming to be
integrated in the kernel, at least from the functionality
point of view, eBPF proved to be more than sufficient
and even better than the kernel counterpart.

Since the data structures and the primitives to manage
the pool of reference values are already implemented by
eBPF (e.g. hash map), DIGLIM had only to declare and
use those data structures from the relevant LSM hooks.

The developed eBPF program [1] of ~250 LOC is capable
of verifying the code executed in the unmodified
Fedora 36 [2] and openSUSE Tumbleweed [3] up to the
GNOME desktop (yet, without any verification of the
data source, or the eBPF program itself, to be done as
future work).

Thanks

Roberto

[1] https://github.com/robertosassu/diglim-ebpf/blob/master/ebpf/diglim_kern.c
[2] https://copr.fedorainfracloud.org/coprs/robertosassu/DIGLIM-eBPF/repo/fedora-36/robertosassu-DIGLIM-eBPF-fedora-36.repo
[3] https://download.opensuse.org/repositories/home:/roberto.sassu:/branches:/openSUSE:/Factory/openSUSE_Tumbleweed/

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua
