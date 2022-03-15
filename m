Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA934D98C9
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 11:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347119AbiCOKdQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347124AbiCOKcy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 06:32:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2136.outbound.protection.outlook.com [40.107.93.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B870C506D5
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 03:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ses6/joZDFtOuQJeJNT9wFfXDQbxnyz+EwpTLeuUUYuyvptQ12EC+kffmESeClOa9uvuk7zCw+Ta2ar6nUB11VDunogdspP2Kw3uYVSy/LIpzOqSgpZapSz6H/UaB7IgUbWpZ6AncO3ly3eGH1lfRnDPo7ITCgt3xmsE+m/AwsfuxZLAx/bl68Y7x+oM1HnMsQHAH6vW4uqFrwv/m5Uso9YjqRaaMajWBjqvLvCEiIJtzIS9rcb0YpuK+eeegp1d0IYV9YudCekSrtIvGYm2u42JUn1bmyum8I5SfXi3xIDbLXnHl2ILuBMLaNnUETP7tVifa4dVnipcjgg/KCZ+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0o4A0+Q3OvBkjrTSsa+hjafeIbv9w7AXHzox2NJsv0=;
 b=Vp58bcl6rbz4NdPbLca3OZCHH8qb5xBArAVvwU4QDFum6h6QxWbjcrHDm8iY8n99o1lfbDtn+9VaEhF01XGXU/Pwj815PUn55SU3y/7OP3IGkvIcqOnWrmejtykUt8eYBx36gRGH7GgqnB48WUWL7inNv4Fqca1jPsvfiE56gzCOTDo3bV00Yx3fHoFxhCgZLfm51bKcaWadJtnYEILpN8jrrEy7+LPQBKVUrF5JpKcbkZcPUtTqCdqPWMrTgF6OyKydanHarq9wPfzonUQoOVcIjPPJ9jSbeMCcNpZgY1pDhnApFKp83wA+a8xHKdI0jJkr6But45Wi782T+3ZaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0o4A0+Q3OvBkjrTSsa+hjafeIbv9w7AXHzox2NJsv0=;
 b=Bii+UEh4OIlDuzSRQp75HvhzzMAN/PV+2EvDkYMSx5pi2msDZgoa0ScItYASCZMrE4EHZ4vEpqKFzSNapjkPr21LQCriF7ulJ14DNBskzk8VPEG4TUJGaj9Oz4PPrEYBeTog67F9nQwpdqMvIQCKF/sQVJda6rB8RA1bkTiwNL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MWHPR1301MB1919.namprd13.prod.outlook.com (2603:10b6:301:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10; Tue, 15 Mar
 2022 10:31:39 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 10:31:38 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Louis Peens <louis.peens@corigine.com>,
        Simon Horman <simon.horman@corigine.com>, bpf@vger.kernel.org,
        oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [bpf-next] samples/bpf: xdpsock: Fix race when running for fix duration of time
Date:   Tue, 15 Mar 2022 11:29:48 +0100
Message-Id: <20220315102948.466436-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0145.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::30) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fdbd6ae-2157-49e7-fa44-08da066efcec
X-MS-TrafficTypeDiagnostic: MWHPR1301MB1919:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1301MB1919385B3E7D428805F71DABE7109@MWHPR1301MB1919.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZqLJz/HC4xM4Au1iZCF4XUrQB3EkraWIBW4a0gGn0KKE2vhGYdGo0NpZeQJUwzrUETlgq5qV23fjPeCpJZSul1NZ9xSshM0enOkPHVHwkYHY4ErzFRg+cfgHzhPmnAdbq/h6QBwwwv0hGtVYB+EuqdACIpZTQYWShcmgrfLUuHAPOxDxfnfscZC1StL96dAN1wUHB1+4VuEe1qnGcyOvxzVrBCLgU6IU26cDZyPSjf6oWOQknHt4tuT5LI/PcV43LZECrgNI9LFrjSaikvax9yD9zHwo55AScXIOG0fwjHvIaPeBIf9t648kZHXnD8q5Pywu0W/EQCXCzmcZif0D2gFRU9TNO9FctuHB2pXks7RdcKFgRs7IXzm+BmwJMoPgla1U6FSHZ8yjo+s3ZJA0jedD7JBCARHxetoiKqmc/5gUFXfAKs8UUo+11/dXn/EU9eddPdEFepyp0t5+CydvTsjXL3YtUao6YdGPm+lxPQX1E81Xlo0+2O2336HDoBIccyDze4HvHxuanvAokjMWMHbUPcqpIcG0L+bOg0uldlEqtWag7EXJieakWJYz0cs6eEgBeKRG9eWpasnOMfSs7bSCWJdpiYlOD/Yw3dvgun2pk5CmEihqOAr79FSw0yg13tgpSzBbuIe5m4jGu3cOPZkFM5mrpbjg04EZJSoTbwZ8p7gsJV8eubx0zqrZilMeoYZB4VoXB/O70TsTM4JFnstfHBlxuvbnmBBhvy+BsYMIk7UBOmuhbJ8/zAJicGo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(346002)(396003)(136003)(39840400004)(83380400001)(26005)(1076003)(107886003)(66574015)(2616005)(38100700002)(186003)(38350700002)(86362001)(54906003)(110136005)(66476007)(4326008)(8676002)(66556008)(66946007)(2906002)(316002)(8936002)(36756003)(6666004)(5660300002)(6512007)(6506007)(508600001)(6486002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzBrc3BxZjJiaVV1NEZnL1ZjMXdLa25EOVg5V1NPbUoxZlgwSUsxUGpEenVW?=
 =?utf-8?B?UjZXQVJkaXArdjZsVXBMSEY1YlV5eDdhS2ZYd3N5bFdFdUJWanVZeVQ3bU45?=
 =?utf-8?B?TC8xSWN1WDRVTjEzVlM0L3ZwZzlSZURDOHh1VElYR3RxNUh6eFdOZlBoVVlx?=
 =?utf-8?B?UTc2NzV5MUdXRCtSeTBVamlWbW1ZYVpnRnFUemtzRXpBdWtGL2RDcUt5dm5y?=
 =?utf-8?B?dlNqUzZWNHNCaUY4NTFqek15V3Z6WUd1Z3RsMDUrSHdZUXd5Ris4Y3ZDcFgv?=
 =?utf-8?B?QlpGR094akpnT2dvVGpJUnBpRSs5aGNIT2ZzMVp2czZnNGlLV1BlMlZWdUFG?=
 =?utf-8?B?TGRqaTFZeDRhWTVTUEFjOHZUa3A1OW4xaUV4Z1F6TG9jMDlGc3hQYzM5dSt4?=
 =?utf-8?B?SEtOZG11eGhDTVY4akFjbXNrWWR4ZnBMbmY4ZmVFdGJYWFBIampQK3ZDdzMx?=
 =?utf-8?B?YjMxN2EvYlJ6czNZZk5aVUFxbS80dlZsMEl1NFllZHJ6NktIMmpCZ0tkR0ho?=
 =?utf-8?B?TThQRVFBb20wa1lyakxId2trWGRPNDJrQ0h1TDlUSmhGVlpnb0t3a2pUTHpV?=
 =?utf-8?B?Wkk3WS9KZFJ5bWRyd2lDOS92Y0w4Sk1FTUFMZnpOU3Q3SWJtWmIvbVViMUhy?=
 =?utf-8?B?TVV1N2E5N0lqazM0em1JZ0g1VG9NK1NWTFo0bmgzYTZpTEZZYS8wK2lHYW5z?=
 =?utf-8?B?ZFdRdVRkYXljbWpOWkVnWUE3aGh2OUlHNERRdWtYUHVIc0llanVRU0RsQ2py?=
 =?utf-8?B?S2hwNCtJdEJlS2pXQ1ZMYUdYUU03aSt2RWV3QVFhRGZFVDBvWGl2Q1JOcUFr?=
 =?utf-8?B?RGtzVmJCb1Y1ZGdTK2FpMVNPWStZaFAyNDRjRXVYRTdWNGtKZzdQcExzWUw2?=
 =?utf-8?B?VWRPUUl2Q0xPNXg4c0VyV2lUK3JBYllUTmViSlM1RTBHZ3RIb0hkTDllRWtQ?=
 =?utf-8?B?QWtVY003MXYrVXFxMnpKL2UxUnJsQmdDa0ZIbUF4UVFIL0ZNM3BxMjNuV250?=
 =?utf-8?B?QnZkdFA3RDFpSTdJS2ZXTjRQeHY1N3g3aDFra1VSaGExeDRLQ2dnUG5RWFNF?=
 =?utf-8?B?dXZObW9hWjJ0UGppWHdKdmVCd1hueE9JZkx6U3FvWlI1WTFCbUVvOGVRSW1I?=
 =?utf-8?B?RlJIRHllYU9hVnJ3WENtNXFxT0l6REVoYVh1S0ttUjhpVFpxT0YyMjBWT2Fr?=
 =?utf-8?B?cUZ5RUc4dVVEcXR3OVRLK3FkWTFMUEF5NXZ0d0dVTmZyN3owYndMRk5qeGdR?=
 =?utf-8?B?SlNSMU9LME5EVXdNRFQ5T0hRQ2wxRVR1V0JqS2xCUEtYdDhta05yUVpjNEFQ?=
 =?utf-8?B?WGpyWnpTUnE0cUFBWFZTQVAwb2VLdXhrTy9iNDI3VHMvVzY0SUduMldXZng3?=
 =?utf-8?B?NlgvODZyd1hWS1FsWVZRMzRWclFEa2k0cy9GeXVFS3l3ZDc2VS9xT2JTY0U0?=
 =?utf-8?B?UC9NaVFlNnRNQVFqUEF1cEZTR0pBWTBFNXpVK3JUWnBQVDVQU3RjcmVJbzM4?=
 =?utf-8?B?YnlnYzFNR0p4bCtHYnJiL253bmJkZzR1Zko4MWtqeHNDNGtzZXI1YVN4bmIw?=
 =?utf-8?B?QU4yYy9zc0dHbHl1QTh1NjVZRlFVZ21oalpvc2VTdnZ3R0sxeExNU3UxTlJ3?=
 =?utf-8?B?NDBlbDErZDE3MVhWUTBSS0pvbmpZd2RpQjJJVkUxN245RUNwUlFCYUdFQi9O?=
 =?utf-8?B?d2s2d3gzUFZQM3V5RDBiLzRBbE5KVHAwU0tnUnFGdHdleEVDZDZGa1pvc1I4?=
 =?utf-8?B?US9vcUd3SURIK0llb25qOHphdG9zN0hXa1dzWEFoWVpJM1VzWnNmbTBwQVRv?=
 =?utf-8?B?eHBQdWx1R21VWFNBcDFlUXFvWGJreE5Dd0RDRlNzU21wUzhDSHhnM1BWalFs?=
 =?utf-8?B?NnREaUlKNGwvUllSNzNzOUQ0cWk1R0VwMldBM0tCdWZibFh0a0xKTDQ3N1Zj?=
 =?utf-8?B?NmRBYS9hdXlnZmRHM05PMkxVbE5HM0xFcW5oaFlpRTlNVis5bDNaV0tOaGxO?=
 =?utf-8?B?S3J5bFhXMWdBPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdbd6ae-2157-49e7-fa44-08da066efcec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 10:31:38.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgT05SROV1QA+ZKHIzgny1Jw30y2voosVJ47m1BXKvkaTL8bhS67/qIp+eHQftR8dk0kIvfzy2R52muh8+udFouZ00PABPHT+3kNXKBW+jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB1919
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When running xdpsock for a fix duration of time before terminating
using --duration=<n>, there is a race condition that may cause xdpsock
to terminate immediately.

When running for a fixed duration of time the check to determine when to
terminate execution is in is_benchmark_done() and is being executed in
the context of the poller thread,

    if (opt_duration > 0) {
            unsigned long dt = (get_nsecs() - start_time);

            if (dt >= opt_duration)
                    benchmark_done = true;
    }

However start_time is only set after the poller thread have been
created. This leaves a small window when the poller thread is starting
and calls is_benchmark_done() for the first time that start_time is not
yet set. In that case start_time have its initial value of 0 and the
duration check fails as it do not correlate correctly for the
applications start time and immediately sets benchmark_done which in
turn terminates the xdpsock application.

Fix this by setting start_time before creating the poller thread.

Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Signed-off-by: Simon Horman <simon.horman@corigine.com>
---
 samples/bpf/xdpsock_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 19288a2bbc756d3f..6f3fe30ad283cf0a 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -1984,15 +1984,15 @@ int main(int argc, char **argv)
 
 	setlocale(LC_ALL, "");
 
+	prev_time = get_nsecs();
+	start_time = prev_time;
+
 	if (!opt_quiet) {
 		ret = pthread_create(&pt, NULL, poller, NULL);
 		if (ret)
 			exit_with_error(ret);
 	}
 
-	prev_time = get_nsecs();
-	start_time = prev_time;
-
 	/* Configure sched priority for better wake-up accuracy */
 	memset(&schparam, 0, sizeof(schparam));
 	schparam.sched_priority = opt_schprio;
-- 
2.35.1

