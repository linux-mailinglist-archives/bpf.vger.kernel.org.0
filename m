Return-Path: <bpf+bounces-9781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B779D927
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461942814FB
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67659A930;
	Tue, 12 Sep 2023 18:50:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6DECC
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 18:50:27 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D027106
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 11:50:26 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CGVtbW029300
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 18:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:from:subject:to:cc:content-type
	:content-transfer-encoding; s=default; bh=s4TjqnjnYCNHsDhiTKHn9e
	8urxzRrvbPrUVmjDpds7Q=; b=a0lEU7Ce6LRI71GqgZ9FNHyhGU8Edx0oZiw1nI
	CFDElgZ9zMtxyj4ThPAuMW50xwibfu0ETX7lPvUH6COcqvQOwFQrJm8OWfouoHtI
	9qSM0m40qR/ztaAGWJt5zz/ko0E5ZmC379mkDKdLsMu60a9YUjuC6BnTUo+ee0cI
	LIV/FIczgCiILkPy0GwlqGcMQIbNuAYG9caXRSKpO58gVlK39XSuA9hg2diEBtoH
	m2XK8y2QjRtZhAEkZUHbCIkW5qQciWeIWtiYZItTTOV/r/pUMPofQlDn9Sjs+alE
	UsblU1GyTWAKkyVF5XtTPL809bdGGFjSX4EEMuVLljKXLaAw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t156a6gk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 18:50:26 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Tue, 12 Sep
 2023 18:50:24 +0000
Message-ID: <f76a8cb2-6cc7-be5d-0335-cc6b98baaed8@crowdstrike.com>
Date: Tue, 12 Sep 2023 11:50:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: Martin Kelly <martin.kelly@crowdstrike.com>
Subject: Best way to check for fentry attach support
To: <bpf@vger.kernel.org>
CC: Rahul Shah <rahul.shah@crowdstrike.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH09.crowdstrike.sys (10.100.11.113) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: DiWYnKGbKt7mEdfsnuzNVjbOyfIDYIY6
X-Proofpoint-ORIG-GUID: DiWYnKGbKt7mEdfsnuzNVjbOyfIDYIY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=797 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309120158

Hi all,

I'm trying to figure out the best way to handle the fact that 
fentry/fexit trampolines are not fully supported on all architectures 
and kernel versions. As an example, I want to be able to load an fentry 
if the kernel supports it, and a kprobe otherwise.

It's tempting to use libbpf_probe_bpf_prog_type for this, but on ARM64 
kernels >= 5.5 (when BPF trampolines were introduced) but before the 
most recent ones, loading an fentry program will pass, but attaching it 
will still fail. This also means that libbpf_probe_bpf_prog_type will 
return true even if the program can't be attached, so that can't be used 
to test for attachability.

I can work around this by attempting to attach a dummy fentry program in 
my application, but I'm wondering if this is something that should be 
done more generally by libbpf. Some possible ways to do this are:

- Extend the libbpf_probe API to add libbpf_probe_trampoline or similar, 
attempting attach to a known-exported function, such as the BPF syscall, 
or to a user-specified symbol.

- Extend the libbpf_probe API to add a generic libbpf_probe_attach API 
to check if a given function is attachable. However, as attach code is 
different depending on the hook, this might be very complex and require 
a ton of parameters.

- Maybe there are other options that I haven't thought of.

I have a patch I could send for libbpf_probe_trampoline, but I wanted to 
first check if this is a good idea or if it's preferred to simply have 
applications probe this themselves.

Thanks,

Martin


