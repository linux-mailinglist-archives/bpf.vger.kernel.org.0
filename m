Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5A64CDDB
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbiLNQUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 11:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiLNQUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 11:20:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C8C2792D
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 08:20:10 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEEHB20021359;
        Wed, 14 Dec 2022 08:19:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=PmwVs6M2SV7vkT1GIIJnHirxuiRx/1/CO+iMliaSvq4=;
 b=Q4DXMY1l0I8IyPjGxH2G4PcqeN1hsCdq2PRrwz5K+XGwLcAwk6qkUGTu4cvXTGQ/B/Gg
 iz2vUMCHLZVAWL7hjEBqHXYGinnnHiccJvMY3rxPxueQ91OQq5CzSemCsTrtk6p8wS6t
 eXUPFvySFq59htLVFykl+lgRQ+k1MfcX/y6geEq1RXCEBCMd1z3leV75vjD1X0u/8S1m
 xmrSbs0Y/Vcel5800h10cIKv71Vca/8nnza7fXX8qbR7XWLpud0ZBcMc+1hVEBZ5ea3B
 Z4Euk5XU1mv6r3wcnz4gRqONHdT5R6AMEWOShqA6FD6p6Cwjp02329XqEGCyWQK0BmXU Zw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3meyf9yccc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 08:19:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvaQw3izoorQu4wbDECWBw1aU5HGe6L1tRaldoeRwOZYx+FXrhmY74DLlKPwZKJhaXQzEQKaUX60C/OI+FirAbMm5IEDy4jtbiMzC636c2LqSVJwu39AB2ReTubcO7BLPhR6xO4L8Hc3v6cLAZlHSy0yk8vVtgKmK4ojuyc0o7tXr+mjx3ZoOwaDHNxCzCCMyMEJWqr2b/WtxZiATuUtjndU/wq+709hh4ZL0uN6yMVUYTZ1wlhvQUhYMc5aZRHHluPm92M3Mf7dajQsqFLcHQgVlIfj0oBbUKMKPXzCuGvvmaHIn2k2mvyPjNqkuBk5iK/vkXSVHqgO2894d6vOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmwVs6M2SV7vkT1GIIJnHirxuiRx/1/CO+iMliaSvq4=;
 b=GhBsWTcyC9jVGyBkn0AERpbMATGwUEEFQssN4qMkJVQ9oTE2+F8ImS11bKWJvrorspiHoZz6ppQucyjFxBc5SlWwTKT7qQXa26sYs6cGkW7f/1alR3lulCmnuffAaR7urDN8Q+PzuTJzcaMO8oDawMlC4g8MClLndxJnrpIkaTwBiOgurx9Fu07br6QVz342g3Hj3rm2QD9aXT35nYyZCredBJ7h81I5jwMfbcgQ8jNflAqRhn4Nau+SkpdjmTnw1C+5c70tUFSlyZPtrjZDBBi2ooIuGZws1uXTLe5Tk152ocAwDMyTuW3ZSBOlZ89jb02d2XPgE+arEhQPxHzEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4178.namprd15.prod.outlook.com (2603:10b6:5:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 14 Dec
 2022 16:19:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 16:19:48 +0000
Message-ID: <3d9bd23e-ba36-bf39-f0fc-25a0ce639fa0@meta.com>
Date:   Wed, 14 Dec 2022 08:19:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf] bpf: Synchronize dispatcher update with
 bpf_dispatcher_xdp_func
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20221214123542.1389719-1-jolsa@kernel.org>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221214123542.1389719-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO6PR15MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b54ac8-1d0b-4f74-f424-08daddef051c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiuPYD/Kc0vMw1rsgMMgZpV7/45IqybKGZkCj/ZZs1W0J7NEGD9RP3SGppBflgI0i+QKLhLXr9NHepRUUjt4L4GGE1cEk9bwabkV+J7G1NjRa7EqNW97QLTo5bndAelozyvYxWIzrAWSPw/sGJHFDuu5ReLPjC5/64akA5ZbfouvZ4w2JuTx0u0BZ5JUe4v6t7gqwVIjFRmx0Hz3gpiQlvGuayqckLIjcVOcAByQX5aNDKgDESdT8pzo0pZlUIXs2RErcQ601vzMbsWmK++zx+qcl3kjaVr73WMeefkyqf2H6gv3uFA6rdXiO8uqQC3ZTlj29ItdYFRrNrK9nHu4S5aoQBfT9mWacTl54vZdvgHFLRU5fEDUqWJ7sMhw7ERjsv4Bt/o0dRnaXWWCJeaBOMJEv7PVjHAJGzTQJDprUdhlHgiIVKIolQzUcNp3l2OTGq14gHVpI3bo0TatI8QT1ZWCZA1DhUzL5RPJnwEmbJk1P4sq6ski08cCqoz+66R1z6h2gL6pjKCgyXcLX3WE0uCl98VT9TGKSfwwA2P32+/TAux1g0nyee3w5tiMnJnfip95BwnKW6e66je6umGsSVdZzPf7UyFw1lrH/MOXCFtWm4mDmyDT4krClRGoWtmM7ZFPsXa27EiAz4U8NgRDDVzm6AxFhvmKn1yffD4YRqcaTAJRwfIzHbq/capY81H6TgSjAPgU/ui8zlDergNBea4h9IAhoKJkHbCONW/T1sd4sDTIXj9aGfQj9osSWZOKrA+3vYh45twbi7wjzz51OuWWSE8dwtGkFKJVSDhnEss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(15650500001)(83380400001)(36756003)(316002)(38100700002)(66556008)(41300700001)(66946007)(6512007)(54906003)(5660300002)(110136005)(4326008)(478600001)(53546011)(6666004)(6506007)(8676002)(6486002)(2616005)(966005)(186003)(86362001)(66476007)(31696002)(2906002)(7416002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEN5MVVwRGk4VHp3ZmRaS3E1TGtmckhSTWJWcmVhV3BQRE5BRUcwRUZKZVdw?=
 =?utf-8?B?a25zU3RpZU9oQURjb3VRZ2ZwVjlSNTJNNGNmcDNUR1JRWDhZSWh4eWdvRGxZ?=
 =?utf-8?B?WVphVlhMMjJsS0VXQXNVQnhEaldpN3lKbTlZa2crczg0a2xmNU1EQUx6Ri91?=
 =?utf-8?B?b0xzQkxUTTNSQnhxWFlPVVFUWnNXOHhvTXFUSlZpcmtrSnZnam1JaE84RXNs?=
 =?utf-8?B?NGkvcFFBTktHRDFQWUZUS29XNjJpTlpQZXY5UU1uOEY5bnM1UGNITEs1SUFG?=
 =?utf-8?B?OTJzVFptK0oyejJFUFJNTlJnYm9rdlRMTmhURWk1d1ZXQ0UwSFFlZHhCWW1l?=
 =?utf-8?B?NzVJclBUWFZyUnR3MDFJTHpHQmR4WUhER1JVQUJMT3VFOUo0RzYrNkVVQU1Q?=
 =?utf-8?B?TFJuSGxGTzhHdFB2dEIzdTdUTXE3K1RtZTVlL1p3NmNTZjVqSEdLVkZuTGxw?=
 =?utf-8?B?RkcyWWJENENzZDdlU0w2QVlMcXRDL3lsckVEVHRtVTdQd2F1MFZNMkUyKzI3?=
 =?utf-8?B?VmtyYnpBMEVFMzZiOHNzTm10WE1wZ1pzMFVVRTJtOFQ0aysrMHF1eG1NZ1Nm?=
 =?utf-8?B?bTFiUVZqTjhMSXhoc3hQaWsrbzFIV1FuQk1uN3BnUEZrQnhlOEd4K004NENQ?=
 =?utf-8?B?eWFQRWN0ZWo5eHlldHVRVHk4bFdPZ213Sks5bTBoTkZCUHdTMTlBZjRzcEc2?=
 =?utf-8?B?N3F0K2kzb0x6MDg5QzNlaVZ2cmxSREFjaWIxWFNUTExPS0J6VGE5N1FZZm5o?=
 =?utf-8?B?QTFDT3Z5T3FPNTRqK3pwUzVPSkdkNXNGV2RTSE40MENLd0R3bU51RmR6eUVO?=
 =?utf-8?B?UlBDN0I3bWZrRUw5OHE0YWcyTHBTVU9rK1hjL1JvUEJVVHhzRStZQUwxemli?=
 =?utf-8?B?MFk1S0ZmbTMyaGloN0VhdE9QbzFFcm1QYmw4aklub0xaK29zdUVnanVUVG1W?=
 =?utf-8?B?aWY5OWJtVk1FL3RBeVE1TTYrSGVpSDVoZURIbWFYVFFyY3RCYVQvVVBXVHlY?=
 =?utf-8?B?M2hmYUV2cjJSb015NEtKNkRsWTl0NU05YWtWc0p0cXF5WmVXbEFiQ2RpcnRz?=
 =?utf-8?B?TzJ4OCtZcWhVeDFuSTVLZlNOUG8zZHFCN3l4akY1dUxheDNpOGJTVC9LZk5E?=
 =?utf-8?B?bS9jSVJnVElHZlFFWnZLSEVSdFBTZkNGZG9KbUpzbXdGbVE3ZVVIQWg4SExO?=
 =?utf-8?B?MUxwaFFnL05IdWwyZEtNYTBpckNJTTlCcWpwRjNJV1o3Wm5KUVNyUjFKN0ZE?=
 =?utf-8?B?eUJseDBlaTV6U3NTaHRmbHh2Ynl6L2VxdXIxUnRubHo4d201QmFKV3ZxZC95?=
 =?utf-8?B?aG5uSzhvdGJKRjhCb1FOYUNPamRQa25lQUk1dEdXU3dYNkxGc0ZWbFdSdmtq?=
 =?utf-8?B?dGNlOHhpSUsvZnJYWXBUb1N5bmZqcmI5Q280YWM1ZG9uSnl6WW5LOWZXWWUv?=
 =?utf-8?B?bis5UXB5eUZ0aVFNRzlyamEyV1hpRkl3VEgwZk9EU0lZd1V0aGVUZ1RveFF2?=
 =?utf-8?B?TlFLYlNTbGVGNDlmS3k4SkZvR3FkdmNuWUx3YytHWElVV1prN3VKYzFoWFgw?=
 =?utf-8?B?YkUxV2dKTnU3cjZ4ZkpmMmQrWXBOclRvckNMUDFBWklQS3RSMXJkcUNzUmpV?=
 =?utf-8?B?TXEwNUNicXI1S0VvUDNKRlByRGUwQXRseVdUZTloTC83UTF4NkNCb2xUd3hG?=
 =?utf-8?B?Tkxnb1JJM1dUNGI5MmczQ3pIZ3ZGbWpmQkFTRXZiM2p3aFJlOElnc3R3LzV0?=
 =?utf-8?B?Z2ZoazZrSG85QloxU3g0TmJzemNRamNLQXRDSTlSTkpaaVQwdE5LRDBGQVFI?=
 =?utf-8?B?MTdsUUd3c2Z6N1l4UWJHbVVHK0kvWWUxcnFmU1hmYXAybk1nT1R1eW4vQXQ0?=
 =?utf-8?B?akNXNFIzVFRKdXNBWmRXdDdTQnVZL2RteUpCdGc1bjUwT1NuZVRoSC82NUNM?=
 =?utf-8?B?RmZ2bGE2V241TVdtdlhjNlBrdWNZQVVxa2d2KzVMbXpnTmpudVA0cno1TDZr?=
 =?utf-8?B?RzdKeVBiODk1V1hKNHljbTBQWnYxZGZWVXZKWFRuV05haDlDREZOVnhtRlNZ?=
 =?utf-8?B?WnhBS3pIUUdYbXJWYUQwc2FHQ0N2SkVNSmRUV3FBZk5qKzVVUERjWkllK3Q2?=
 =?utf-8?B?VHpXdkt6alJHYldzZUxTTHlPa1VLNzdURWJJbFVFa2ppOUFRME1LRDZxNEJD?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b54ac8-1d0b-4f74-f424-08daddef051c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 16:19:48.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMD4dSxK5HyOjrpSj9j4xPM5cKtOwo3bcUoDnwQ/J/xa0pYt2Ktqfw27EwuwDbQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4178
X-Proofpoint-GUID: 9opzItxym5aIzg_qJBVr-qQcp9qTQhg0
X-Proofpoint-ORIG-GUID: 9opzItxym5aIzg_qJBVr-qQcp9qTQhg0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_07,2022-12-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/22 4:35 AM, Jiri Olsa wrote:
> Hao Sun reported crash in dispatcher image [1].
> 
> Currently we don't have any sync between bpf_dispatcher_update and
> bpf_dispatcher_xdp_func, so following race is possible:
> 
>   cpu 0:                               cpu 1:
> 
>   bpf_prog_run_xdp
>     ...
>     bpf_dispatcher_xdp_func
>       in image at offset 0x0
> 
>                                        bpf_dispatcher_update
>                                          update image at offset 0x800
>                                        bpf_dispatcher_update
>                                          update image at offset 0x0
> 
>       in image at offset 0x0 -> crash
> 
> Fixing this by synchronizing dispatcher image update (which is done
> in bpf_dispatcher_update function) with bpf_dispatcher_xdp_func that
> reads and execute the dispatcher image.
> 
> Calling synchronize_rcu after updating and installing new image ensures
> that readers leave old image before it's changed in the next dispatcher
> update. The update itself is locked with dispatcher's mutex.
> 
> The bpf_prog_run_xdp is called under local_bh_disable and synchronize_rcu
> will wait for it to leave [2].
> 
> [1] https://lore.kernel.org/bpf/Y5SFho7ZYXr9ifRn@krava/T/#m00c29ece654bc9f332a17df493bbca33e702896c
> [2] https://lore.kernel.org/bpf/0B62D35A-E695-4B7A-A0D4-774767544C1A@gmail.com/T/#mff43e2c003ae99f4a38f353c7969be4c7162e877
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
