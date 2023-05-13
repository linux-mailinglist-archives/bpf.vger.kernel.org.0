Return-Path: <bpf+bounces-462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5924D70144A
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 06:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFBF1C21241
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCABECA;
	Sat, 13 May 2023 04:13:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E511EC0
	for <bpf@vger.kernel.org>; Sat, 13 May 2023 04:13:38 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBDA3A8E
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 21:13:36 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34D35aCG001381;
	Fri, 12 May 2023 21:13:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=oxaeoGquF4dDxfJAUgu0PG3sI/r+Ra5nvtodFCNrM00=;
 b=CKh0fqHpqSLhCkMq5J+u82uhVXkto3W6IMk8RI/ZyhmUZTcHrqcclQE7UOeTR2kGWxUG
 Jofrd1z08rcH3WpdVcsonw3zZwPeqWl54/2CIF7ev1jmxKdVWh9AEQ5Ezj9cH6dRwBAO
 P3lDhk4JLMHZ8+Vn9fyGVZkBJemWwuU1M2ONIp4LnH1aYr96BjrsWZN3BajKoJa0HpVh
 0Jwj6Ef2UQ5xBRGdo2aGi5yjwv31Tg/YNmE7UfM+yAZb0f1D1FsBEnoRM2XZBfbbmEOd
 Yn+2ld1qMwLvPipxRUT7j3/3twWALRk/vcFxJ3cE6KL2Q9UTuTis9qFRVhTwGV+mLCaw NQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qhb35v13n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 21:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/w4jGiH//yCJnNKWyBkznzeV7doSDTl+ifqrbryp+tC0p8WYx8m8YkHjyLwOchBnC+PvCOmPPW5pzfL5AuuE7/5kxBfTsNPCjFdg/rkqPQRs1gaHKtW/LNUCTR6+lxgPiLY8NbEIm/YmJheqPggMFc7LsNYyclxFTcCyQe7B942OKmHD4WgRa8/v9jJ2Bz049pTcujUFhnrFgrfPTew0IKo6w6+4asFQ1ZLVS7gAGF4sgLWU1yJOLAkk8nUbUJC1Qwjg9a09F0NXRlFUPYskLld+tblSB5YEm+i683nGhAtYyJIgdEk50UoaFkDJboKze1Q3x7w775x4haJNQdpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaqcxDZxhKW/0K7soj95cUq1zPx3kGR3oYSU72NaUOk=;
 b=jxCbqnk/mvEjaOnmxTisqBM6qiwzz7KXB2Y7kHPoKfecEb0f2rHGyCkBL4qUHLVoDaFIZBywuzXwa0gWqlSKmQyQQhOrEfHnQNm2T85hEsbJas45UHZ4wOojnCB9lsIsmU5vM/lDlYK5Q3cpJpGtW3L+KxWTt2RKbcdJyHc+quC7GMcKA6Peww7AUcgwsp9kQM+rbcsAQ0bKqwbo4wj1nKbrcgarx8/J6vT0CAznnAqBdBINhBNWu7wAfvr3YghujKLBRHtCnUwBcE20Ghwufm3OC1A2r58uDvU3bL06tDziozg5GWJDhFL5kdwXO5XvuLKeEjxvZBDAT1mudw7Z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5812.namprd15.prod.outlook.com (2603:10b6:a03:4e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Sat, 13 May
 2023 04:13:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Sat, 13 May 2023
 04:13:24 +0000
Message-ID: <8376a6d2-a3bc-4742-254f-a05605002c30@meta.com>
Date: Fri, 12 May 2023 21:13:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu Bretelle <chantr4@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
References: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
 <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
 <47d0a6958657890d84dbd944782603175268b340.camel@linux.ibm.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <47d0a6958657890d84dbd944782603175268b340.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:a03:80::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 54211949-7fda-4df9-bc4b-08db536864ec
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	urxjy4eoUv4YDE07fMJp1WuLyNSbSufD/NMojlZnhykZDdi7tcJ6OdWUmzc9w/MQi3MaLMkq7D93x7gNLQVetBU3qoxPCKX/GadfyPV72ZItqw4PHJI8eyaAvX7xuuhsVoIY8bEq7YpeypHnWRcq8hPrzf7Ou0TzcgaYTLyAiGQH1BsRjmv0OizPQtED+m4FQVoMCZdnUO9j6+vqLIARvk5hcKJd2mt/V0FB+TWnACD9GQfxFkvBZhChl1VSW0EQyS1KpXKZuzDjfjzX3p6yiKuX1cM4RmMT5sx3rPb32hjYG45XLPTOhPj8kPZqSvAwG5C/uMSObt/L7mrpJQuO7MDVjidZo/egmAY+4w+huUTiZ1RobSDbcXmhjHAmOK0xxnx1CYRiKG1p/wLDdmUPtwo33tgWfT1AZfcEeR5BStgTh8HSnBIkzGGIrIDZE5dhWVwpk7nnE5XeBerpSXRzcuMpEMYy7jQVoWTRUjp1z4cI/ioUvWQIUzS55Am0tEoHG6hPYz2Zqui0fSZ9EoTTOO4Fc8ANTZ8iA/Wbj7cv6x5+IBHilCEPx5a9pQ+Rt5BZWqAnU3KugSfbK3yIwnWm+ajNhZ3R1Vog+zGCSNJMY6owN+dZl/SfGCjtILrnmv1JIJjxiO3OPVMhFPfsTcGDNA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(53546011)(2616005)(83380400001)(2906002)(186003)(6666004)(41300700001)(66476007)(6916009)(66946007)(316002)(54906003)(4326008)(66556008)(6486002)(478600001)(966005)(5660300002)(6506007)(6512007)(8676002)(8936002)(38100700002)(86362001)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dEtTU2JpVEg5empOWWF0QTlGVTV3Q2hSeVBuUnJmK3R3aWlWNkRDRDFic3N6?=
 =?utf-8?B?YkZaNkMrNndDWGE5ak8vNzFkMDZmM2lwVzBQMU9nWDFjenoxM2Z0ZnRDcE9X?=
 =?utf-8?B?WXlVWm56cnVFQXBZd1A3cmhmTDN4L0ttZ29zTUpSTnVYTzFxbEUyOE0wbUI2?=
 =?utf-8?B?aGdLS0JHSzJsSG41cWZreTB2ay9UOFJaMjMweG5OU1NLTkpONFNtUGJEQzY4?=
 =?utf-8?B?ek9vTnFlWjdlMmgvTjYvRXE4czBhNUNIOWk2RFAvNVh2KzBuQ2xFL0dNQWpY?=
 =?utf-8?B?MWpCUkM4bmZ5TU41U09QWXcvNlJSbXYvMnNRZi9HQWNaZzlueWczVERDanRw?=
 =?utf-8?B?YjNXQXE1Vld6Q1NZQml1Zm04SVZJVk1VdUsra1BzRlBGRFdvUm1vZDVCRWk1?=
 =?utf-8?B?WVNHWW9rL2RpQ3IxR2dkMjIwTVFWMXN1WFNPVGhnemZqRHJLVFJqVW9XRkFi?=
 =?utf-8?B?TnlTczZTbmJJZWwzV1hrdlBHUmRwZWlVK3pjREN5WWpHZHp0Qy81VDRQTGpm?=
 =?utf-8?B?OEwwdmcvai9sZ2J6aExWRWdoVitkcDZuYmlsK2ZCQjJncXF2TTNBYk5BZUNh?=
 =?utf-8?B?a0pKNzhYYlNadEErK3pNK0FNTE40dVVFRHNMM2VvbllpT0kzdkhPeDZqY1Nw?=
 =?utf-8?B?WjNRQ0ZLM0IrMkpTaUM2a0xUSVY2cERyR1d4OW9PZ3FjVzhjQzVVekhBSHd2?=
 =?utf-8?B?dEE0SldtQjNiMm4rME1pS3JucTBFR3VQeFJickNNMWRmcm8wejZ5TUFrdEVs?=
 =?utf-8?B?RUo1NmxNd1VVUTFZY3l2NXhtUEpnTFR3RHUvU3hDWFNEN2RiVTc5MGhKZFJ3?=
 =?utf-8?B?WTNoV2syekpIamQzS3ZnL2ptdlViZ0pWTUhsdFY3VGxYVHMyT3NwemUrVjRU?=
 =?utf-8?B?QWg4MTZLNjdTVDBDZ2ZGM1JEOEQyOVp0TjdqV2ZqVnlDR0RkaFZoN0tlWitY?=
 =?utf-8?B?N1QyL29KRmdRMnJHb2h0U3lxYkowQ1lyR2tnTnlSWVF0WWpxV1c1WmVNWWwy?=
 =?utf-8?B?M3RnVHdUaE4xWUd3akZXNDRUVEROOG00ekNXTTM1NllIbTd5OEF6QTZXYVp1?=
 =?utf-8?B?T3o5aVA0RSs4WGpHQm5TYzRkdXI1WnRaejJhcksreVRoZTNNWkZrd2Y2WjhG?=
 =?utf-8?B?UzVKd2R1NzNhVGZzQ1paWENvK0EzV1RGM0NRNFJBaklZN1NuT2F6TXVuNVNq?=
 =?utf-8?B?WVdIaWFwaVA1R1pvOE5STDI2aUtMVVU5VmkxZzY2azV1c1lEME05SFNNV1VN?=
 =?utf-8?B?RjNaT1VNaDh5Qm5ISEJUbWJ1eG94QjNIZWZCay9KU3pUbExRUGdmWitqVkh2?=
 =?utf-8?B?RDdRS0toaks1ZjdDWUMwVlMrekZ2UG10OGlYbVJGMkxlNEM5dG1JQ3c4ai9U?=
 =?utf-8?B?VzZjZnQxWHp6L2I1cDZjbG1EdUtBR21mZG9pSStISnNzM09PQmQzb0QrbGl3?=
 =?utf-8?B?U2ZLS2dtTE5aOUp3Y2lxZzFlRXZ6TmtqZDhzd1hoUjN3eDNHV1I2bDlwMmk2?=
 =?utf-8?B?eEUrOHZUektSMlJsMGVycFBFckh4Wk0xb0pKS0dEZlFXcjFWV3F6SXQrYnlU?=
 =?utf-8?B?YkRublZOZ01Vd2w3Z2tmNUJybXplODJHRjJEMTd1WVZjSVhYZkZUYnA5Vnpj?=
 =?utf-8?B?a2xmWjMyMG5PQmZtMEtIeXFHWXhiUTUxdnJPOE1lR1plRktwTmZiT3VMRWJY?=
 =?utf-8?B?enBFL3BMdEY4T0YvWWxpc3hTZ2JMS2VRaFh3OFlXM2Vaa25DKzEraGxJVzBD?=
 =?utf-8?B?YkZnOStGeTZoK1lnQjVsQnp3ampkaldSTjVueG05TzBZSGZLVWtBUHRxYm1S?=
 =?utf-8?B?N0lYbzFZelhwMW42SjhxT0xncEthMThzVzEyOURuZGJpOXpRWXVPZGxLU3Jo?=
 =?utf-8?B?UWVCM29ycHdlNnpKUHpxSVZ1ZzlJdFplS0JWZk1iZU9zSUJxejcxQm1GQytP?=
 =?utf-8?B?dTBPRXZ5TWl0WkQ5dUVUWGplSnRWTGR5T0lyV3NXa29JUW9vY3BZRll0MU94?=
 =?utf-8?B?ZFFtWHYxenNYOGVSRSt3c2lwNzdUd2RCSlVvbWN6UURiYjQwRHA3Q2g1WStV?=
 =?utf-8?B?enRQZlJxWWo3NGtOaWZDeTczemozaG1FemhXOWN3cklkcnFGQmI1SitxOHBv?=
 =?utf-8?B?TzhrNU5QTkpjMGtNRVRnVmM0Vi9BYWoyTy9BMmorRHQzWWVBQVhtNGVlcDZW?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54211949-7fda-4df9-bc4b-08db536864ec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 04:13:24.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWX1wCnzqEiGcIWNOgXhxDphVDLKjlYsKbGKy8IPyxpqzUUNKhcMBVp7DSpsgN/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5812
X-Proofpoint-ORIG-GUID: fH4yxfA5jg9dGB1Qm20dXIa15b37jkPy
X-Proofpoint-GUID: fH4yxfA5jg9dGB1Qm20dXIa15b37jkPy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-13_01,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/12/23 7:40 AM, Ilya Leoshkevich wrote:
> On Wed, 2023-05-03 at 21:46 +0200, Ilya Leoshkevich wrote:
>> On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
>>> Hi, Ilya,
>>>
>>> BPF CI ([1]) detected a s390x failure when bpf program is compiled
>>> with
>>> latest llvm17 on bpf-next branch. To reproduce the issue, just run
>>> normal './test_progs -j'. The failure log looks like below:
>>>
>>> Notice: Success: 341/3015, Skipped: 29, Failed: 1
>>> Error: #191 sock_fields
>>>     Error: #191 sock_fields
>>>     create_netns:PASS:create netns 0 nsec
>>>     create_netns:PASS:bring up lo 0 nsec
>>>     serial_test_sock_fields:PASS:test_sock_fields__open_and_load 0
>>> nsec
>>>    
>>> serial_test_sock_fields:PASS:attach_cgroup(egress_read_sock_fields)
>>> 0
>>> nsec
>>>    
>>> serial_test_sock_fields:PASS:attach_cgroup(ingress_read_sock_fields
>>> )
>>> 0 nsec
>>>     serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_port 0
>>> nsec
>>>     test:PASS:getsockname(listen_fd) 0 nsec
>>>     test:PASS:getsockname(cli_fd) 0 nsec
>>>     test:PASS:accept(listen_fd) 0 nsec
>>>     init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt_fd) 0
>>> nsec
>>>     init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt10_fd) 0
>>> nsec
>>>     test:PASS:send(accept_fd) 0 nsec
>>>     test:PASS:recv(cli_fd) 0 nsec
>>>     test:PASS:send(accept_fd) 0 nsec
>>>     test:PASS:recv(cli_fd) 0 nsec
>>>     test:PASS:recv(accept_fd) for fin 0 nsec
>>>     test:PASS:recv(cli_fd) for fin 0 nsec
>>>     check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt,
>>> &accept_fd) 0 nsec
>>>     check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt,
>>> &cli_fd) 0 nsec
>>>     check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
>>>     check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
>>>     check_result:PASS:bpf_map_lookup_elem(linum_map_fd,
>>> READ_SK_DST_PORT_IDX) 0 nsec
>>>     check_result:FAIL:failure in read_sk_dst_port on line unexpected
>>> failure in read_sk_dst_port on line: actual 297 != expected 0
>>>     listen_sk: state:10 bound_dev_if:0 family:10 type:1 protocol:6
>>> mark:0
>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>> src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::) dst_port:0
>>>     srv_sk: state:9 bound_dev_if:0 family:10 type:1 protocol:6
>>> mark:0
>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>> src_port:51966 dst_ip4:7f000006(127.0.0.6) dst_ip6:0:0:0:1(::1)
>>> dst_port:38030
>>>     cli_sk: state:5 bound_dev_if:0 family:10 type:1 protocol:6
>>> mark:0
>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>> src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1)
>>> dst_port:51966
>>>     listen_tp: snd_cwnd:10 srtt_us:0 rtt_min:4294967295
>>> snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0 mss_cache:536
>>> ecn_flags:0 rate_delivered:0 rate_interval_us:0 packets_out:0
>>> retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0 segs_out:0
>>> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:0
>>> bytes_acked:0
>>>     srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272
>>> snd_ssthresh:2147483647
>>> rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
>>> mss_cache:32768
>>> ecn_flags:0 rate_delivered:1 rate_interval_us:272 packets_out:0
>>> retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0 segs_out:3
>>> data_segs_out:2 lost_out:0 sacked_out:0 bytes_received:1
>>> bytes_acked:22
>>>     cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730
>>> snd_ssthresh:2147483647
>>> rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
>>> mss_cache:32768
>>> ecn_flags:0 rate_delivered:1 rate_interval_us:925 packets_out:0
>>> retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2 segs_out:6
>>> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:23
>>> bytes_acked:2
>>>     check_result:PASS:listen_sk 0 nsec
>>>     check_result:PASS:srv_sk 0 nsec
>>>     check_result:PASS:srv_tp 0 nsec
>>>
>>> If bpf program is compiled with llvm16, the test passed according
>>> to
>>> a CI run.
>>>
>>> I don't have s390x environment to debug this. Could you help debug
>>> it?
>>>
>>> Thanks!
>>>
>>>     [1]
>>> https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jobs/8679080985?pr=224#step:6:7645
>>
>>
>> Hi,
>>
>> thank for letting me know.
>> I will look into this.
>>
>> Best regards,
>> Ilya
> 
> In the meantime the issue was fixed by:
> 
> commit 141be5c062ecf22bd287afffd310e8ac4711444a
> Author: Shoaib Meenai <smeenai@fb.com>
> Date:   Fri May 5 14:18:12 2023 -0700
> 
>      Revert "Reland [Pipeline] Don't limit ArgumentPromotion to -O3"
>      
>      This reverts commit 6f29d1adf29820daae9ea7a01ae2588b67735b9e.
>      
>      https://reviews.llvm.org/D149768  is causing size regressions for -
> Oz
>      with FullLTO, and I'm reverting that one while investigating. This
>      commit depends on that one, so it needs to be reverted as well.

The transformtion "Don't limit ArgumentPromotion to -O3" is temporarily 
reverted. But it could be reverted again once the issue is resolved.
So it is a good idea to resolve the issue in the kernel.

> 
> But looking at the codegen differences:
> 
> $ diff -u <(sed -e s/[0-9]*://g pass.s) <(sed -e s/[0-9]*://g fail.s)
> 
> -pass.o:        file format elf64-bpf
> +fail.o:        file format elf64-bpf
> 
> -00000000000002c8 <sk_dst_port__load_half>
> -       69 11 00 30 00 00 00 00 r1 = *(u16 *)(r1 + 48)
> +00000000000002c0 <sk_dst_port__load_half>
> +       54 10 00 00 00 00 ff ff w1 &= 65535
>          b4 00 00 00 00 00 00 01 w0 = 1
>          16 10 00 01 00 00 ca fe if w1 == 51966 goto +1 <LBB6_2>
>          b4 00 00 00 00 00 00 00 w0 = 0
> 
> This is what ArgumentPromotion is supposed to do, so that's okay so
> far. However, further down below we have:
> 
>   Disassembly of section cgroup_skb/egress:
> 
> -       bf 16 00 00 00 00 00 00 r1 = r6
> +       61 76 00 30 00 00 00 00 r7 = *(u32 *)(r6 + 48)
> +       bc 17 00 00 00 00 00 00 w1 = w7
>          85 01 00 00 00 00 00 53 call sk_dst_port__load_word
> 
> ...
> 
> -       bf 16 00 00 00 00 00 00 r1 = r6
> +       74 70 00 00 00 00 00 10 w7 >>= 16
> +       bc 17 00 00 00 00 00 00 w1 = w7
>          85 01 00 00 00 00 00 57 call sk_dst_port__load_half
> 
> so there is no 16-bit load anymore, instead, the result from the
> earlier 32-bit load is reused. However, on BE these kinds of loads
> for this particular field are not consistent at the moment - see [1]
> and the previous discussions.
> 
> De-facto we have the following results:
> 
> - int load: 0x0000cafe
> - short load: 0xcafe

So 'De-facto' means the above is the expected result.

> 
> On a consistent BE we should have rather had:
> 
> - int load: 0x0000cafe
> - short load: 0

What does 'consistent BE' mean here? Does it mean the expected
result from the source code itself?

> 
> Clang, of course, expects a consistent BE and optimizes around that.
> 
> This was a conscious tradeoff Jakub and I have agreed on in order to
> keep the quirky behavior from the past. Given what's happening with
> Clang now, I wonder if it would be worth revisiting it in the name of
> consistency?

If I understand correctly, I think the issue is
     r7 = *(u32 *)(r6 + 48)
     w7 >= 16
     w1 = w7

after verifier, it is changed to
    r7 = *(u16 *)(r6 + <kernel offset>)
    w7 >= 16
    w1 = w7

and the result after verifier rewrite is completely wrong.
Is it right?

If this is the case, during verifier rewrite, if it is
big endian, say the user intends to load 4 bytes (from uapi header)
while the kernel field is 2 bytes, in such cases, kernel
can still pretend to generate 4-byte load. For example,
for the above example, the code after verification could be:
    r7 = *(u16 *)(r6 + <kernel offset>)
    r7 <= 16
    w7 >= 16
    w1 = w7

Hopefully, we won't have many such cases. Does this work?

> 
> [1]
> https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@cloudflare.com

