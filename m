Return-Path: <bpf+bounces-9454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A386797D28
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA582817C1
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D61426E;
	Thu,  7 Sep 2023 20:09:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCB14008
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 20:09:34 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA50E47
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 13:09:33 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387FFUZG032513
	for <bpf@vger.kernel.org>; Thu, 7 Sep 2023 20:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:to:cc:from:subject:content-type
	:content-transfer-encoding; s=default; bh=Q1liHipR3lMRTC9eVfz7oG
	/0Iz6O1PGWlncAsdRsP3o=; b=EN83prTAGWHNzATL4bTznJNMR0CEAgFwNONA7z
	mOOU1kftEs4/artyz92nZvbxtjqpD43mU95IFfkBx2qipOvVhQMh/lK5vpUnDj+Q
	J5jhxoRy1qBFV1xIbSloCAPAZlZRFmJvOjsVBGoi+gj25HksCDV2TiGYaf6HGRzD
	NqY+LeOHme3lzUZInjbHAN4gekhw3te1ivWga8bxL2dNDGEe/KefH9dTCI7YbHLO
	5NfYZN9O8wh7KVEMAa+6focFkat8TiMlYS5a5PewYoezlKf9llgEEvOxbWzsmuSn
	4y/btMbnuCnS551HLEscpVD/jHkLHo2GljsFDknTtrsuO6wg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3svhhabe2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 20:09:32 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Thu, 7 Sep
 2023 20:09:31 +0000
Message-ID: <eaed0418-1315-44a4-96d3-d6dbd4d999e8@crowdstrike.com>
Date: Thu, 7 Sep 2023 13:09:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: <bpf@vger.kernel.org>
CC: Marco Vedovati <marco.vedovati@crowdstrike.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
Subject: libbpf ringbuffer callback prototype
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH10.crowdstrike.sys (10.100.11.114) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: T40mV2i9kIiqAGge-0h_zo5-emCWzpri
X-Proofpoint-GUID: T40mV2i9kIiqAGge-0h_zo5-emCWzpri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=580 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309070178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I noticed that the data pointer in the libbpf ringbuffer callback has 
type void *, without const:

typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);

However, if you actually try to write to this data, you'll get a SIGSEGV.

It seems to me the prototype should ideally be const void * so the 
compiler can throw -Wdiscarded-qualifiers if someone tries to assign it 
to a non-const type. I'm not sure there's anything to be done about it, 
as changing it now would break the API. However, I wanted to mention it 
just in case anyone has thoughts about this.

Thanks,

Martin


