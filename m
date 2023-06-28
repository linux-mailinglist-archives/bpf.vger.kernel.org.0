Return-Path: <bpf+bounces-3610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C1E74074C
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF3C281179
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 00:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359D1377;
	Wed, 28 Jun 2023 00:52:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA111376;
	Wed, 28 Jun 2023 00:52:53 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00656296D;
	Tue, 27 Jun 2023 17:52:47 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RHWVTt012721;
	Tue, 27 Jun 2023 17:52:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=DZ9/07S7dLQJQXGPEr5HMtOLW3PKJGYAONlnq0w5EE4=;
 b=gSFwnjPPkFC5w0zYbq4iqwfb94HHjeHpyWFjSgAnhJ9iZt//kGBfGWBIehEt9ILAvAnx
 Qje2IEw6HGf+OGolrlQpqN93HF7vNIMVBJkZo+J72+8cgbNYOd1tIyy5KnWAoo+nxpW8
 zFqefTmlD5eIuGo0Ql6zqGnaP+9l6IdzmKiyGOaa59JX0HA1vNGsmnqQRWsKoLeQqaQI
 kktgYBKE6T0dtdeemHV8dH4NrRHVlIfO3MXuGdgLhslpIAOO174DSXz8HH4gTCKQ78Gm
 Kg2J7choT2f5JEJcCQLsMHt3NJ60esNzORtqqWh59OjJq/GpOmc5CdT+tU1qOZfBc0i6 /w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfvqjq23s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jun 2023 17:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeDZqQwk1r5JvmJ42IMVlYAnMNRNPbf2ro6p669hJX+/tCn74UJZnz+xJOqlMywLABbRnjTr9c4acUrAgAeXQ/qlFV1urB9pSQrOK68JlVTfEcIvYVVaafDA+5RxsoNCIaFLe133cSvwgHgoLz21mFj95BOJy9wAoUZ5voL45KALFjFVGTKSSroxz2d+wZri3sSNClPkV6eKhx5WwWzKkaExc0VXNx8c5aS/j976F8RSclBnmevYtuqrj97JO0hVNyUSkTL1UnHLyzH4vse3ssYI+rygoc9lItl+ozaL40t4Z7ucNMiZfWxfknPpH8Js/To+ngCnTCxzAeNWy9eMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ9/07S7dLQJQXGPEr5HMtOLW3PKJGYAONlnq0w5EE4=;
 b=QjPLGokt7f/7ZdzEjw1B+fLDJBvTgvTBl/3GDQb37AeuCguniDfymFbVmp8Ep2E6F0C2emI6zVYsYPSxgG4Lk/8bLX0gYMsmzTaFk6q6mzt9jX1X7WMU24e2a3I3C9HRsWk03Vyt+ExgzQ4CL41ZqPGagSJ48+CXv/++64DOGu15lF0eeHft1HOGgnUmkzOJQYxthD54uhwl+rtbMRoRstXuu2WCIEKvEBygEWBk8n+f2cR2oVINn9atf1PJSqYYu5o6+SsLrq8e0XbY4dqKzL6FvFUkrHNQJIJ5IqPk1fK37H4D6d/a5QsMajBSvs6TfYtJEahNAl5QJUCwqTMp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4902.namprd15.prod.outlook.com (2603:10b6:806:1d1::12)
 by SA1PR15MB4756.namprd15.prod.outlook.com (2603:10b6:806:19f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 00:52:11 +0000
Received: from SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6]) by SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 00:52:11 +0000
Message-ID: <d0e0c583-48a7-715c-8bdd-15e0d061f126@meta.com>
Date: Tue, 27 Jun 2023 17:52:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Hou Tao <houtao@huaweicloud.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        paulmck@kernel.org
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com>
 <8f2d98bb-51b8-b61f-1f6d-59410befc55e@huaweicloud.com>
Content-Language: en-US
From: Alexei Starovoitov <ast@meta.com>
In-Reply-To: <8f2d98bb-51b8-b61f-1f6d-59410befc55e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To SA1PR15MB4902.namprd15.prod.outlook.com
 (2603:10b6:806:1d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4902:EE_|SA1PR15MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a725deb-2257-481e-e786-08db7771e84c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kkwAKXs9u7WXhnbfH1TRmKnWHJEMPPDeRym/6bZWofHferNZa5G4H7z32sCZSlydrA/BjcewOFUu01W1YUdpZi2R/sBl/x7hsawgQTqVYZVMzTivnJsSRcK9a0z2PfmnRyQw73trR81Dta9jgQqYZIkabSFSOabjZQhjujpC9tUUFAeVEZ2BQtN7N6lz8H5BpFDwGsg7Tb7WjCvOkLvqTNCeGVvTQdDZ1zmKvFezHAV8imkKG/BLB2nxpMpw5nk9VQtzMi7+hUeJ8yxsALECKj4KrPsfk3q6kD8LA5Ev001E6pg0FeRzRyv6BuPvm80+KxklOoJA9l9IHzXJAcwNsvfoUG+giygbPydp5v59/npmsTE4OKqZkbWbCw++9OIcvVN6sWXxDDLytHXOt45y/a/eT6NXA11Ulbp6Pm2qgOaxguALLVzl+sA+WC1MTimfJN4+7thgaOaI+xOeZrSowIXTWbqgkY1Xv7T7FShxRomv752WUMsCwliNj4xdkX+znoXDgptEqzOeSW/o2TyEaqr99vtetzBn90O+Bn+OUG5McrR4NZ0hWoy8pxAhdQvqhA+Jo6XNk34HZqBML6fohW9SX136YTOJn9FeWSBYpJbRHtCqmzWt5ylXW67tE7/wBcrk/4JCzrQgjW1M7d6A8Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4902.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(2906002)(86362001)(6666004)(6486002)(38100700002)(53546011)(83380400001)(2616005)(186003)(110136005)(41300700001)(31696002)(6512007)(4326008)(36756003)(478600001)(66476007)(66946007)(66556008)(316002)(31686004)(6506007)(7416002)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEoxQmY4Qm5xUVcrRmIxOGNQVTJMVWx5OWpxNFhEZDVsKy8rMlk5T3k4TWhS?=
 =?utf-8?B?NnFHZ3RVdmU0bWpvY2IwSytsYXdNSEdNTE82NFM3UWh6Rm1lNjgzcW94dTZG?=
 =?utf-8?B?ZmtzTElKOGNjb2t2TXJPcHhObVhjb3BPZ1ZvbmRoSXFIb0lhd3FyNzNVKzNH?=
 =?utf-8?B?U2NrNTRQMFN2SFhla1NNaG5WMDhhTkQ3OUxtNHR5bk9ZS3ZNa3Ewa3IxRWVw?=
 =?utf-8?B?VmZvZkZPcGwyVm1TQVRiT3QrNGlOMWZ2Q3Zsc2I4Y2tVOGU2N0UrRFlkN2FM?=
 =?utf-8?B?QVdVRndIN00vcVFNUGZMVDhBaDBCOXNQRnNTTWx4TENmSmZ2dnlxS05VWWRx?=
 =?utf-8?B?NjRpYlFCSFpZeExNcndrcXlYelpNNzZJMkxyTHpFRUdRQUorK3g0a2dyNFhk?=
 =?utf-8?B?SDhUM2hqK1lxb1NxQlRBUTM0RDFXS0VWSWVHclJOWDY4M2NYTEdwdTZqTGRP?=
 =?utf-8?B?ZzA2RDRiYWd1NitNTG9EUDBJS1ZSR2Z5V3A1VmFVTVFWVWh0aEZIR0tEdVYw?=
 =?utf-8?B?NytCNkFnTThTeGNsOHdHM1htYk94Q293VUhNQ2c4bVVLSXpmNXBab0s5M2l0?=
 =?utf-8?B?YkllSGcvQlp1dWJxbk9kaVQ4b013b3pYdmg5cjU5MmNlL1BPTFhLTFpmcnRM?=
 =?utf-8?B?WUluaGo5NUs0ZnE4MjBDai8rd2tiNVEwbEIzbm5NaWhkNzEycjZLZHhYZFhI?=
 =?utf-8?B?WGRhcUVJbWZEaWJCWitXSkZLaFB4OHVISkkxL090a0VhVzFFUEp6RTl2c3JC?=
 =?utf-8?B?NFB0c1M1ak5oQSszcFBQT29VSWpvUk5xVHVIR056cjVtOGY1VjJPakUyajUv?=
 =?utf-8?B?eXJPL2Yzd0VkNXIxWFZPMWtBd2NObjdQQUpkQmpVM1BWcm9BZ3YzV0ZnR0hL?=
 =?utf-8?B?Tk5vd0NMU1FCU3NjcUJRSWxCUENnc1ROUlBveGxqYitwTnliY05vWEdOT2Qw?=
 =?utf-8?B?YS9wZUZ0VWRjdGw2d3BCMVByaURjNWhNK3ViNUFjNTYyY3FlY0dPVWVMMzEr?=
 =?utf-8?B?OVBIdnliREdJdUVFZ1RZaGozRUdMTVdCbjJnUWFtb3Z0VDFWVy84RjBTaGs0?=
 =?utf-8?B?ak5OMHZFWDMrcVUvaVBTZFlMR0Vsb1BqcnNqTVp5cm1KM1pSUjZNRnNwZDZx?=
 =?utf-8?B?Y05CTXNVRVZTWkM3NWhYWmQzcHVFenpmR1gycFZaWUpCdS9hc2VyR255UkNF?=
 =?utf-8?B?dmxxMmQ0aE9OVGVVZkZZU1JSNnpJVXRmQ3cvOEl4b1hGZ2p6eDdlbVZLWnc4?=
 =?utf-8?B?NzRsL1lySG0vbFI3T1J3dkRvT3ErMlFoTHc2NUh2a2daRjErUUhrTXlXS25F?=
 =?utf-8?B?ZVFRQmV2VE1hNW1neFVRWXhxVXp6V0lGRTNYcUVzQ0RqQ0hyUWFBVG1NQ0Ns?=
 =?utf-8?B?b0VvbUtuTFZ1SXhURkpPL3k1Qm4vcGcvR0pvVWpUdnlSbldXNDdOVEFYWTgy?=
 =?utf-8?B?WjdkWFVzaGZPRWZuZVdVQ3dLb3dmN0pLaVNnUWl2L0xXelZodVp5QU5YcllP?=
 =?utf-8?B?Mmt3Rmg1YUZHai9Xei9nY280N1JIQTI1b2RYZDEyeTZuRk5GZXZ0ditrN3Zi?=
 =?utf-8?B?R3k2LzlrMUxuT25uVnNZRktoVUd2ZnVFV0E2ZlV6T1ZlakoydERaVGlDcVph?=
 =?utf-8?B?N2xWZG55cUpEMkZaeUhWSE1DZTRQWHVrT3NlYmlKcW4rNStKOG1TMzF1V0ln?=
 =?utf-8?B?UVI2ZGdkeEh3eTdhNUFwUElwWGN4aENOaVo1VjdzL1pYYjNLS0pSc1RaUlZT?=
 =?utf-8?B?WHZjMTI0d1pLWVM3S0IzYUNQMXhSUW81YW5LZVJVam0wbVZoOXdoUDBhOG1h?=
 =?utf-8?B?bG1hV25id2dJM0hIZTF1Yis2SkFRL3VvMU5DSGhIRkJUcTdxdlQyU3NSQzAx?=
 =?utf-8?B?SzBKNWJtMzcvZ1Jlcmo4MERoYUF0c1VoRHA3UGFtZkNhemhjNWVNdjNta3RQ?=
 =?utf-8?B?V0NkVVFCRWgyU3czcmhZSEdCTDFINlFsZWhRNEpEVU14V3hWYnZ3bHppOSs5?=
 =?utf-8?B?N2pnWEt1N1JSODZIOSs5NkNXaG9IWlpZaWpEOTk1UWw3M0xIemxoVXVkQ0pK?=
 =?utf-8?B?V3RZQkVJVU8rZ2F3RWQ2eTBHSzlkazV6c1ZqbGNWMW54djBSbDhvV3AyQVBh?=
 =?utf-8?B?QXA3WjlMSFY3WWJWY1J2Qi9NS090UEtiSzdad3VVczNKR296UG9jUXNZWDdB?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a725deb-2257-481e-e786-08db7771e84c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4902.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 00:52:11.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH0pP8jw5EN8K/UurbWDWslC+DozODKUuClLV3vytrQW0nzB6A68Gly2fgphP8NK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4756
X-Proofpoint-ORIG-GUID: p1M8ZFWbXJJAvb64GOcVe-GQBVKAXQbS
X-Proofpoint-GUID: p1M8ZFWbXJJAvb64GOcVe-GQBVKAXQbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/23/23 11:49 PM, Hou Tao wrote:
> Hi,
> 
> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
> SNIP
>>   
>> +static void __free_by_rcu(struct rcu_head *head)
>> +{
>> +	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>> +	struct bpf_mem_cache *tgt = c->tgt;
>> +	struct llist_node *llnode;
>> +
>> +	if (unlikely(READ_ONCE(c->draining)))
>> +		goto out;
>> +
>> +	llnode = llist_del_all(&c->waiting_for_gp);
>> +	if (!llnode)
>> +		goto out;
>> +
>> +	if (llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace))
>> +		tgt->free_by_rcu_ttrace_tail = c->waiting_for_gp_tail;
> Got a null-ptr dereference oops when running multiple test_maps and
> htab-mem benchmark after hacking htab to use bpf_mem_cache_free_rcu().
> And I think it happened as follow:
> 
> // c->tgt
> P1: __free_by_rcu()
>          // c->tgt is the same as P1
>          P2: __free_by_rcu()
> 
> // return true
> P1: llist_add_batch(&tgt->free_by_rcu_ttrace)
>          // return false
>          P2: llist_add_batch(&tgt->free_by_rcu_ttrace)
>          P2: do_call_rcu_ttrace
>          // return false
>          P2: xchg(tgt->call_rcu_ttrace_in_progress, 1)
>          // llnode is not NULL
>          P2: llnode = llist_del_all(&c->free_by_rcu_ttrace)
>          // BAD: c->free_by_rcu_ttrace_tail is NULL, so oops
>          P2: __llist_add_batch(llnode, c->free_by_rcu_ttrace_tail)
> 
> P1: tgt->free_by_rcu_ttrace_tail = X
> 
> I don't have a good fix for the problem except adding a spin-lock for
> free_by_rcu_ttrace and free_by_rcu_ttrace_tail.

null-ptr is probably something else, since the race window is
extremely tiny.
In my testing this optimization doesn't buy much.
So I'll just drop _tail optimization and switch to for_each(del_all)
to move elements. We can revisit later.


