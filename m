Return-Path: <bpf+bounces-1969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2427725027
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 00:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2921C20A1C
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6A2D252;
	Tue,  6 Jun 2023 22:50:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECB7E4
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 22:50:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA310FD;
	Tue,  6 Jun 2023 15:50:16 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 356If9ca003697;
	Tue, 6 Jun 2023 15:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LqPXx4L6BCWPcSer+OWYQUG2Ect6UFtZPTwiqv9voBg=;
 b=VIcTilEzfdmTviiLN5eMRLIBHszmYc4I56zCF7EnyRJ4Md16xh72h/GkYaBPG6vLWw13
 WcCSI191n1tT75pMjeO2bl+Lqb+j3zNGmX8PiUIVQ7UdcL01hTYIWGagToVgxPJLn4E7
 vyOTF+Lav+thU5dTCzeNe2BvSkj4QUC3MeoMN9eNHuLG9c6bU3aYG1msD+ScP6UZXmez
 W1WRYtVnSadwMdS7gsz9V0bnPv+9JY1+t3K7roMss2LnQuF35VAdCfH3x4L6yMXDnkTm
 lwKlicsO9fpNYZcC3UguUux+sWFznNwJ0r9td4G57XlT1wvnb4E8EWIsY8xiPXYgndWH vA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by m0089730.ppops.net (PPS) with ESMTPS id 3r2a82hrps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5SUee9SJcqXT60g8cS9tOeFjZxTw8Iw3rwbKM3wq+WCuCuiVRKV6NUnu0Wd8Yz2TojrmyQS2i/LTaac6S6trQ8bHRWWLdK7zGXdLo2/VQqLva0XyuswBgUUcilDS6kg6h4j+fw9QVhHWlbKLa7GofsIlHjT+ZLCYgBNcP2jb6dn3nMKELOCE9E9S3DqL43u5V1niYCqrkq5NZqn6k/nbcu7+1gmSO6WKBvMwKjZsqvPeYWOd+unHr9AuIWXI5MWfTQblzk/urylCZI7TDrQPph8mx9BPxyBQMvbJ1+7PZqjEG+icr82rUCS70xlIiwkKeOoIgJAM7vcGu0JIeVwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqPXx4L6BCWPcSer+OWYQUG2Ect6UFtZPTwiqv9voBg=;
 b=WmAfxHh0qZd0VzNQYBxQ2Y7MigEZEqQAyxewlY5EmX1PJfwo9Iw1v4cr622N3dqvQk+zngVj9qW4Ivw5wSk+CYWhbO4CvRsAvb0Wmb64+Y/dce0/x8u4HIU2jYX3SnuTY+a6rMeWEzTFgeuGNH1iHaLY0uq0gCTNxKWr7TsLWdtB2L6nI55f3QHPtghDIXu9e3E1fsUF9j8z7/Owp75Cd7/kk4axzagPintz3I24Ytm6aQjHcJfvn4I7Qe1C9LirKmR6LGsIHozuDzLByTP1+QSUz3LcR25jtUvwxnybVgRYMjEJnZNQvPDDtCKUr3dqzOLAi9JrU77ArrM3Gcm6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4586.namprd15.prod.outlook.com (2603:10b6:303:107::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 22:49:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 22:49:09 +0000
Message-ID: <ec58af39-9c97-2032-585a-6dbaa890206f@meta.com>
Date: Tue, 6 Jun 2023 15:49:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] [v3] bpf: fix bpf_probe_read_kernel prototype
 mismatch
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Peter Zijlstra
 <peterz@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230602135128.1498362-1-arnd@kernel.org>
 <20230602135128.1498362-2-arnd@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230602135128.1498362-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: b312cdd3-1c88-4941-d613-08db66e03d30
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7tbjdGFW2wm5ty9A7U4C+dU+jJaJk+UT+E+970tUixGVSf/AtN7768hRc8yJwbLDQuaEFTwxHeGnwaek2+F++I1anaXWLWo1K45E8xH2FAigboXu09jiYf30fxkPnOqFrSR314ZHgmI0/qgIK9+f0TJhN4lFCvmNOrlbC0Lif/8zgndcrXhX9JLYwwTCN+beiGjG/WsipMxMGC0RFQxp+AGHQkpSEblPfH8yvApdplyNqZw5uPE5bHpIBkHn6/QQApQekVB5EG9s2etujc/R6LjxOQO7ltGJcubxg1fClCesLQfQCk2xqNVbMV2x+n4t5pscoFiSLlbJe6Vlii03XKA/76Gsp4zhnRRBn+g1VRqLmDWXFl0gs/Kc6RZ2xJTdifkUkM30yqGpLgkydW3amdEXOmsukVm2crp4wbld9k+oN5lDouNMnXCyFEkVNt9EFzXW4SRhziEdWgMgf3i2vLq0E64AAJsdb4MEexAB02HAWAcQ9MkZ+sKOkTQtjIGCd3QsfZ8S2HkKRgpO0Jv0ov1nC0LkA8bgYfvF59qa5YW6zci0rW3wOzxIV7NEXVvm2eQf2pnBh1/y9BaEtzhwUv7s3p/W81wIQYqfk9aUOPiTKzKrFFgK52QdRMVSNzpfHh48TUHi/nOHJHulMTp2pQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(6506007)(53546011)(6512007)(36756003)(83380400001)(31696002)(86362001)(38100700002)(186003)(2616005)(8676002)(4326008)(41300700001)(110136005)(54906003)(66946007)(478600001)(66476007)(2906002)(316002)(8936002)(31686004)(5660300002)(7416002)(6486002)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGlXditFbnhXbWJOMDRMaHg2ZStleGNIZitWSXRDOEpsbzFHcXMzRFVQaFM0?=
 =?utf-8?B?RERNdEJleWVZanA1QlJ2bysrRWpUZm1NZFZjdUE5OEFhYVR3YzBmOHBqc1pE?=
 =?utf-8?B?MVZpWDVzWFM4Y29WV243TVNvcDJSTkp6QWQ4TXo5T1o5aDJvS1RQams2MzUz?=
 =?utf-8?B?WmFPVk80ZW8zQXFPNTFmSVlRNk1WOCtoZlJIaWptMFNVN1A2VW5FQXllZzlU?=
 =?utf-8?B?ZllWLzQxWndnQVNqdTlQa3JPdTNmUDZuVVRLeHFERVE0ei9oUmdweTNid1pI?=
 =?utf-8?B?anhITGo5RElGaCsrYklYaFd4T1BrV0xvWFpUQ3FuMkJMdjlSQXQ0ZU5SVHJN?=
 =?utf-8?B?aTlCaE02c1Ztb0p5U205aUlIOVBhMHBNc1grY212RklPUmNwVTBDRGxISFNK?=
 =?utf-8?B?RkNNVzhGZ0NOUnFqanRiSi9uWGRvL2xuSnZtR1ZKVnhiOU41dE5lVWQ5cEtL?=
 =?utf-8?B?S1NXUTNqOWFkVS9YWkZyQjBYSnFGRVFtd0VYclRDU08vTTJ1YVBaZk1TV3h5?=
 =?utf-8?B?UVc2OFYwc3hlZ2F0a1pSQnlHZTJGSVNUQ045R1FGZE5IaEFnMWRzNHpHaU9C?=
 =?utf-8?B?K3NYOWZXcHB6L21WMzdTUThSd2JTdlpZRTEyZ0ZnV0hRVlhuamdEL09DV0dU?=
 =?utf-8?B?SFNCYzNFUUNtSlJEbXYyemtkTmxMeVljOVVwVGRoaDRSK1pRRExkV0t2T2ZP?=
 =?utf-8?B?YUlkREpWM2RDeTBMay9CRS9XMFlsa05mL0RUQlZjRHpMNGRnNVRnTTJVRWdp?=
 =?utf-8?B?Nk1LOHB0Y0V2WjRBVk9wbjFxUmFaSnRxRnlWSEVzS0M4NGU4aWROdC85WmJH?=
 =?utf-8?B?QTBaV0RPTy96VFBsMDdnaGNoWmhVM0JWd1YxYXRZeDQxZElFRnhPTVdvbFZs?=
 =?utf-8?B?N25LamVmUDRkMFdyWEY4VUZwNkltR255QTR3QzRkKzNuL1Y3NDJ2R25pcGsw?=
 =?utf-8?B?UU55NytJSkdsVkc4bjVoSlBxTzBIZHE3L3RmR1hIaHRKTkNKS1o3THV0clpu?=
 =?utf-8?B?ZzRYdTdhRWpybldGS3lTOVlQSUpkUktiRVJBR2Uwei8zY2dndnd1Yk1CZEto?=
 =?utf-8?B?SFV5Z2hHMjhLblVjSXNwcDlqK3F5cXNjNTlQV2FkSUR1Z3dFdXN2anJRMnB5?=
 =?utf-8?B?N0NCc0EzYlZlSFFaanQxZGJJcTJOY0w3QU5HeTZxSVhqRyt6b1FuenVYSDBV?=
 =?utf-8?B?Y1hhaXluUTVUMFpXSDhDb3I5N0lOaGpUdGp4TGs1TmtiN3RwT0ZUa2lhWU9p?=
 =?utf-8?B?MnhWWkpZRnNiNkRwL0tQaFdoK2N6Z3kyM1RaaHNTYm5KREUzTTQ3aFZSREJv?=
 =?utf-8?B?L09Vd3ZYOHdaNVB3QjFzNFd3Mk9FUWZEZHhIQ1UrclUvZlZvV2RBL2VYbDli?=
 =?utf-8?B?ZWtKb0ptZ3J3Y1J1M3RITzYvUVdYQ1E1Y0s2SzIrNG0xOGpCd25yTmtvb2Y0?=
 =?utf-8?B?VUgzRDlVVWR2WHBKalRSTmZTYlB0eUNJbDlJa01sbHY5K2ZVRnVlTHl6eUly?=
 =?utf-8?B?di9TcGt3KzBPMjRkKzlyMTR0cEw1VWxrUHRPUDhXL3FBNDFVRUhEK0lMYVhW?=
 =?utf-8?B?OUdlUXhoMTBYbXYvVURaL2I0eEI3WU80QUIvU2hUNXBWanh4eXlaY2UxT2NH?=
 =?utf-8?B?SVhFZ1E0MXZybHJzdVY5eFZSSG1DQmRkcUNHUVRYSGZTQ2tGUTYwQkZJR0Rk?=
 =?utf-8?B?QjNtM25FYnZBS0xrWVJUc3JuaEhDTEYyNHNWQTg1R25pOUhJbkJ5M0psWWRm?=
 =?utf-8?B?anNycTF5a1lUeDZqcDFDejZjTis0Z3NXY1RWSEExL01sSGQ2ajk5bXo5Lyt6?=
 =?utf-8?B?SC9CMUEvckdFV2FzSkNzeU9xR1NmZy81Yis4RkdEallaeTNtWlI3WGE2aFNo?=
 =?utf-8?B?bCtYSncvMWptNFNOWitTTGl2cE1BdWdDMUdONXc5ODNtMjhNbEpOTmk3T3Qz?=
 =?utf-8?B?NjhPTVdYSXVsb3l1cGo0dGxPNnE0UWlpWmNUcFlqOWVPSDd2dHF0VG9KQnZv?=
 =?utf-8?B?TXdOaFUvVjk4eVgwM0FMZGMrSS8rZjdSRENtU1UyUDUyaWtxRDFSMUV1YktY?=
 =?utf-8?B?Um83dW1GMEk1VFIyZWpWbTNpOEsrUEZ0NFR5clRNaXhRSFRkNkoweVdXODlF?=
 =?utf-8?B?SmRGNFg1VytvNGR0V1ZvT2FNUlp3cm5oczJoRXhIUmF6VEE0dkNLSGtkQkEv?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b312cdd3-1c88-4941-d613-08db66e03d30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 22:49:09.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuqZgFYkjdo40uH0eNR98Am1SW+1Aymfrkz0sQunUnvYi9zKibnb7z4nxQSNo/5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4586
X-Proofpoint-GUID: y1FJtwYZeb6m1ISP4oY-BPV_LC5CUCwZ
X-Proofpoint-ORIG-GUID: y1FJtwYZeb6m1ISP4oY-BPV_LC5CUCwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_16,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/2/23 6:50 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
> 
> Since the two are incompatible, there cannot be a shared declaration in
> a header file, but the lack of a prototype causes a W=1 warning:
> 
> kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]
> 
> On 32-bit architectures, the local prototype
> 
> u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
> 
> passes arguments in other registers as the one in bpf_trace.c
> 
> BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
>              const void *, unsafe_ptr)
> 
> which uses 64-bit arguments in pairs of registers.
> 
> Change the core.c file to only reference the inner
> bpf_probe_read_kernel_common() helper and provide a prototype for that,
> to ensure this is compatible with both definitions.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Yonghong Song <yhs@fb.com>

