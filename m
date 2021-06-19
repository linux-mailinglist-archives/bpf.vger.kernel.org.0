Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64E3ADA82
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhFSPMZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Jun 2021 11:12:25 -0400
Received: from mail-eopbgr670086.outbound.protection.outlook.com ([40.107.67.86]:46062
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234545AbhFSPMY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Jun 2021 11:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/pqsZI8KzGTWr901chMxTbGWTQ91p4OfMQnWvzcKaUDbuMY0BiNGy0HAQQC7ZoVLYeLaKb23Y+rPR7TziBOLZxaID7jow5pZOUR0vYwW6BvE52Chq8f8Q1qqPkulpYCrenIxC12x8DRzcmjkAxrc/ny7G8aNiZk3rpCwuLXcZTArEi8XPVp/moclsryk1PxL14gOgT84qmb5sZQ9cyz2PUjsWYrIwsNKhqX9Q6cNogZ7JXP6JanJP/kFZoMWHnleTCN5cNouKFkMaQzJVXKMfKdGDXqgtQaR0wPH9oG1RChOB79lXNdd4zD04wv3jhQDhUv3YUwCfxNf696CZ3Hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl4wNwG1TMxu8JfJqwSwoQTXZASw0m7HaoMsnKnqkxQ=;
 b=JgtaGBGCqrSE7WLhew1mO1uGqicUnIV49nBgNvQLARK3dsoNl7hPYbeLd8tJSTQ5P8Pl8ILJRgm4eW1UO71WhODtptnm1YB37udwHp9Jq3+i2UJrRivioeHJujRN2cQuatdNrhwhnm1b6aMg+9Cb8BHYbeKOlbkVnW0nMmY81a2NzdSQIKnNCzXWiDoaaZ8gjowTmXNMlIXBofGu2C9SAIf4Pj5bVzLpIOUiDfGrb9yiK3+7C5NyjcKuPtCnR/oURR5ClwyPqUDzShP8Hg4Gblo/rG6XskfAw9Ru8bm7TmxFUJXQ7d3tkbhSPOUbjZ5U9MdOk8cy7XX8mbdXkzYI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=165gc.onmicrosoft.com; dmarc=pass action=none
 header.from=165gc.onmicrosoft.com; dkim=pass header.d=165gc.onmicrosoft.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=165gc.onmicrosoft.com;
 s=selector1-165gc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl4wNwG1TMxu8JfJqwSwoQTXZASw0m7HaoMsnKnqkxQ=;
 b=dkv5m9W3yLaXDXKFwyyYUKeITmcsL1+vYmsY1/G9quQ/vOmjwWPoFFontzhhy1P8Xs2clxOTBJW87TSz/ZDNCxtZtCcjrZV0/0DmgUq+qM2R/v8obUJVEH5UEUjgDDhLuh7k3GFoz6F78KfqOB9HKIRdf1TJypEMpdcyk23co9w=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=165gc.onmicrosoft.com;
Received: from YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:17::24) by YQXPR0101MB1942.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:18::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Sat, 19 Jun
 2021 15:10:10 +0000
Received: from YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c132:2223:87d:9e86]) by YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c132:2223:87d:9e86%6]) with mapi id 15.20.4242.023; Sat, 19 Jun 2021
 15:10:10 +0000
Date:   Sat, 19 Jun 2021 11:10:07 -0400
From:   Jonathan Edwards <jonathan.edwards@165gc.onmicrosoft.com>
To:     andrii.nakryiko@gmail.com
Cc:     bpf@vger.kernel.org, jonathan.edwards@165gc.onmicrosoft.com
Subject: [PATCH bpf-next] libbpf: add extra BPF_PROG_TYPE check to
 bpf_object__probe_loading
Message-ID: <20210619151007.GA6963@165gc.onmicrosoft.com>
References: <CAEf4BzZxHSAn6d7M9O5_HE7p5K-Z2OJ1E9f0YGXfAbdWhsZ1GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZxHSAn6d7M9O5_HE7p5K-Z2OJ1E9f0YGXfAbdWhsZ1GQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.91.65.25]
X-ClientProxiedBy: YQBPR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::42) To YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:17::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 165gc.onmicrosoft.com (174.91.65.25) by YQBPR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Sat, 19 Jun 2021 15:10:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bbd51e-5373-4cdb-875b-08d933345463
X-MS-TrafficTypeDiagnostic: YQXPR0101MB1942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQXPR0101MB19428DC0758DD32AA937CE5E9D0C9@YQXPR0101MB1942.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcbvVlAxPKmPuGpx0o7oIrMK7RAUkarT1KVqG+yki0AKyAiPyHC0ZlTJ57TQfNnoMPNTuXniyQqDeC87+icPuYljBzlEJ+qwNk06irdG8POERvWqTIxglehpVSftTSfsosq6SdRvOmgaumcywpPaYDWjpbnK0Wcvz+2VNLZ4WMVm3WTxGQ18zfjiKQ6TNM0J0nMfOrF1sB97GrhJCYDIr1O5JugeN0B4fYhlqYrqMxfHQ2wDEUnrRx/LYLCgfRHMHKSlXi9VtlnzAYxGoEz0lvEloyHQYzVa3HLQtO2Z60VQ/PMLrw8dvxMXsUsbRiPUoSLYQrLAXfQxA1ykBjIf2+8BcakUdiSgwBc2ePrthy4ldMdSBjgT+8M9TT7z+Xn1YkFeiL8ZRbq70afp+i7wPOmRTVjAXctXANsx0+KZyVA52WO93mmfWhBI07QL/blCm6+SCQIYwHaRKU4yAjXD3eiXHWEa82NYHfCYJT76VQIPXq+nVIjSXaE/U50238YYoCPEtgqgVcSkx5QTRBp+P8V7QT7/soX6lmKl7/lHdQyLBg/toO4dSH2+1uM7QN93eSPTjW3mF38fXqUymsjuAYfIDtzo6KOmQVUCtq1DWeu0mLgCSdaJCP8vE95h7KWUQELWYGoz278fT5QritWOrZpxGCK2eKC2zUBSKG8GZdu+9bweHEIDYv3Lzwr58OfK0Yxz4U4dC42ePXkU91hNORskTcObI6GXyv+x9BrfjLbO6EqZ6jklsi9DiLQhi5AhRiUPyiTUrxlaUP9/IuAomS0OYyCEQUBb771Uqht9tyFX5+Km4fl8GbHVrQlaz37v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39830400003)(346002)(136003)(376002)(66476007)(66946007)(2906002)(83380400001)(186003)(16526019)(107886003)(5660300002)(86362001)(2616005)(956004)(6916009)(66556008)(8676002)(478600001)(33656002)(1076003)(8936002)(38100700002)(38350700002)(4326008)(55016002)(26005)(52116002)(7696005)(966005)(316002)(44832011)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm0vNFQ1Y0VNb2dPS2hmOW1pV3BOR3hRZkQ1Tm5sYjM4RGdDOVl0S21JeFhL?=
 =?utf-8?B?aTN2NnUzWjFIR01kcEo4ME9abXhPMHNtUmJpVTNmeXBRcWdwTjBFa2FwOVpk?=
 =?utf-8?B?TnA0WEZoRktZUDhjczFnbTVKblpFMTBGK0kyU0JGZE8vSzdnelNkeWl4L2xi?=
 =?utf-8?B?ZjdHRHVzWTB6ZlA4QlptT3FKWHFNeVlPZ0NSeVpNeU9zRkxEZ3U1U01mcUl3?=
 =?utf-8?B?T3NpVTJiTkNkYU8ybmdmTnA4MjhyL2ZJZnpQSUEyZXhUUVI3bjFhdEdaakIv?=
 =?utf-8?B?WWhGeGxVZHFGQkIydUhZai9DT0p6eFVLK0JUbXpYUEU4cjI3QkQ3Tkp5WlRC?=
 =?utf-8?B?cnVYbHFkVDJld3RQU3BFQWRSdFpRMkg5U2dzOGpTY3hWcmYzZUtPNnVXeFFP?=
 =?utf-8?B?QmllM1ZqeFB1NEUzc1ovVlJnQ3Nwd09WbHpIczVFNXNsSXUwdE5neEdDMXgz?=
 =?utf-8?B?Q0JBQXhBTU83RllRK1loK0VPUExGZ2tYWGJMN056RktKbGlpa2s3QWcyeEN1?=
 =?utf-8?B?VzRvdlFuM2dZN1RLZHZNcWhNd0FNTDRtTmlYd0VqV3ZPRHpnSG8wLzMxd0Y2?=
 =?utf-8?B?ZG9LRy9qWk9UcnEramoxWTRUS3B1NHZNeUlNcXFINVNaMVlOSi9aeWNmaVcy?=
 =?utf-8?B?Q1ZLMGRnNXl4N1F3ZzF4a1A0K2tGL09LcEV3YzlQTzB4Njk0TFVWd3dkaUJB?=
 =?utf-8?B?cWF6bTJRSGxqZnRhSVBXUTE0dXRuVHlIVC9Vd0swVE84R0llSit4alZWU1Bv?=
 =?utf-8?B?RFN2SzBCZ0RId2NNRmprVEJqQ2ZtcGlucS9aaEx5VEdENG4remh2bUxoZ3NB?=
 =?utf-8?B?UHhIcDUweDVRZzFRRU9nRERSM0FBQkEwSWVvcDRtdVl2U0JGb1kyMkdKaTNr?=
 =?utf-8?B?NWNlREJFbG5nVTlCV1l3S1ltV0JCZXEyWS9IM3ZKOEhtdy84emtZYzVpM05L?=
 =?utf-8?B?cEg5bGNzRTZlRFJlWkQxc0YvN3dRanY0SmlTZTdoR0MzcXZTbHNZUkE0K2FV?=
 =?utf-8?B?cElyd3I2ZzBqOGdhYUFmNzVScVFOKzl2TEhKN3lpcjNuRVJXczh5SlFSb0wy?=
 =?utf-8?B?ek9pRk82MWdKamtOSnBkZUNMS3R2cERsWUZHZ05QQkJqNUlObFUrT1c5QVNs?=
 =?utf-8?B?cDl1UlROTDBkNmI1V00xMkRBeTlYSzNISElKcVpkU2xwQVBGa1Y4ZDlpTjZi?=
 =?utf-8?B?UzdDcEhSVkMwUTJZWHZ4OXlCc1ZuZHRHYmo0WVBZaFBkQzhnTVAvbHUySWps?=
 =?utf-8?B?bE5yZDljM0EvdVlPV3dZSFp5Nk1QY0N2blY3WmVQODQ5TWlwK010MWpaU3Ju?=
 =?utf-8?B?UWdFZnh2Tk9GSkZpVlp4azdvMUFuQktZdVNPeEswcFRtMVNLSUpxTU4xYWE0?=
 =?utf-8?B?WGZOWlhtN0tpVGZ3NU12QzQvYVdRZDA5SHEzQTNBcTV1WVhFNWcvTFFFRVNz?=
 =?utf-8?B?ZzRCdzRReWlVQzg4NXFmMUdFYkVwcHhzMEd3SjU0Q2ZCamc4TE1xanBvZ3Jv?=
 =?utf-8?B?VFhYeG45RHF2MFdMTEVQd0FDL1lPTkF0MmkvNTRJdnloelpHMWphVHMwL045?=
 =?utf-8?B?T3pqNm9ZeEhPemhteUtmNWtPZzBranF3VmRmc1d2bXBoNytOdkcvajlhZUhQ?=
 =?utf-8?B?eHNsSkt5anBjZTZqbTZVdHI3eXkrQURPS1FnZjhBNW9pMFRKTFU5WHVtV0d6?=
 =?utf-8?B?R1NDNFZLN3BaN0ZObTFacG1uTGVteFM1YUQxUzdKYkFSL0hRREp3eEdBTXBX?=
 =?utf-8?Q?2py7pbkJVOClMFs24WlxAwy3K/htGnHJ/f0G6cO?=
X-OriginatorOrg: 165gc.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bbd51e-5373-4cdb-875b-08d933345463
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2021 15:10:10.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fa9b7bc4-84f2-4ea2-932a-26ca2f5fb014
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Mwhtd/EsPs0X1Dei7wVvrzVu3H42qDuS2xfdJKdC+ykSgDIMNpYkZSEYJc3eWL4jOLgrwEoKn9CQUTZrm25GVGjzDFyle6eI+FnIw84h33MnudPuz7Lo/+hQTDP3pSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1942
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF has been backported for RHEL 7 w/ kernel 3.10-940+ [0]. However 
only the following program types are supported [1]

BPF_PROG_TYPE_KPROBE
BPF_PROG_TYPE_TRACEPOINT
BPF_PROG_TYPE_PERF_EVENT

For libbpf this causes an EINVAL return during the bpf_object__probe_loading
call which only checks to see if programs of type BPF_PROG_TYPE_SOCKET_FILTER
can load.

The following will try BPF_PROG_TYPE_TRACEPOINT as a fallback attempt before 
erroring out. BPF_PROG_TYPE_KPROBE was not a good candidate because on some
kernels it requires knowledge of the LINUX_VERSION_CODE.

[0] https://www.redhat.com/en/blog/introduction-ebpf-red-hat-enterprise-linux-7
[1] https://access.redhat.com/articles/3550581

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jonathan Edwards <jonathan.edwards@165gc.onmicrosoft.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 48c0ade05..1e04ce724 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4000,6 +4000,10 @@ bpf_object__probe_loading(struct bpf_object *obj)
 	attr.license = "GPL";
 
 	ret = bpf_load_program_xattr(&attr, NULL, 0);
+	if (ret < 0) {
+		attr.prog_type = BPF_PROG_TYPE_TRACEPOINT;
+		ret = bpf_load_program_xattr(&attr, NULL, 0);
+	}
 	if (ret < 0) {
 		ret = errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-- 
2.17.1

