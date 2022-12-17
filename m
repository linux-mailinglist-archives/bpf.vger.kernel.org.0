Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2364FC0C
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 20:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLQTRn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQTRm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 14:17:42 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028DFD28
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 11:17:41 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BHGIkpa008551;
        Sat, 17 Dec 2022 11:17:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=I/ZaNZ55SEhYoU1cl/VoaTxiuE4IzSmu7oQcb3uJ4QA=;
 b=i4XERWgpmORexFQjvuLzF1UKpThhiocvxF7HBlbcKlN/flhmTKSWqCV2PfjvIMfhOpdK
 MU7Z9+VsPiaJtZZoT7xFwCieqNke/4OMULb+3dyhR0PR+NnuzPLKXefIN/2zgYg9c7Wp
 DeThmZaTV3nx0T0YmNW4dKCX94jv72WvO3MS6lXZc+nHFhJgQp20RPIor+THPkMLPuBZ
 omWyFg/J5u49pjsLy85w9Fsp+c33oavYIL88+Rr8Ng9VWsVVXnjqWGD2cLnzki2A8dIf
 SVngo2gg365V8i2CdWgTkSPK7sc7KJqmH41X7FosXzKw178hvFP/D5V1QpqtR30F4be3 Uw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhcd3s542-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 11:17:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq6iAvJybIB70keBARVntzSN3fBfncQMOtdcGDwgZUjGlAj0asNHZPF+v/hlNeP6UBo6qYmTJXWfg7VH72PjbtqNj/UbpWyHh12Hbyf0zLh+jOZ95AfKQI/NfGem/uhMSKcB1Sd8nmVx6is26fOjEcED/2kfNiunrYjIL7ergc+Z9UGlNEICos95iA2pQibL4kvDNUsk5AFu9JmXEAUiFWkfXmf59eptVV9UJoDpDGLQUNaYm9OhIRQhphoNOg5Mv+5GzPnnNU5OOBfK34DE0CBG+x6NTb/zlk7vO4TCboXu/Vn59DjxRRdujHwRawEG4gCiuBav8VBzHCtilQpAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/ZaNZ55SEhYoU1cl/VoaTxiuE4IzSmu7oQcb3uJ4QA=;
 b=DXiyK8FDKnSyGoJFHLpNXZE1aPONDNXdBAaS2nwV41ykhMeclxFFCpx3lFhIBHq+1gFHbfnd+a/BtPGO+yEMOW+hQnwfTpxJjtZu6qIY2PEJo8UdDqZwxfIkmvDF3YYG7ThbG/qzesMeTVD5JBAVXHjBfyp6FbQamZlj5IjTaT0N3Ozl9Xw4q0x4z6qNkNn152mQShyEBtoor0bm0s7Osybo0Hgh9tvArNMG7tEADoS1tkQgP54dbLlp8b9H4fD9dekehd7cPLvi2nwrDaj4VspnYWBp15rMY2uO/iuVsxmwYy8y64T1dlD5g+VeaMJ5AJnoNxmoUrBv8vQJWkhjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3787.namprd15.prod.outlook.com (2603:10b6:303:4d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Sat, 17 Dec
 2022 19:17:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 19:17:24 +0000
Message-ID: <8a4added-f30c-3eb0-bbca-c3e0fc178127@meta.com>
Date:   Sat, 17 Dec 2022 11:17:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: check if
 verifier.c:check_ids() handles 64+5 ids
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com
References: <20221217021711.172247-1-eddyz87@gmail.com>
 <20221217021711.172247-5-eddyz87@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221217021711.172247-5-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3787:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e161a5-5159-4f99-ea6a-08dae06353fa
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAZ4QcphR1k6bhegcUTNdyZECzTwp66Q7/UMpu0rlcJLvGm4119pEsHYUTVNSIeqJmm13NZ0bAN/Pjh77vfzjKV85whzIOPUMC2gBjRfLFiBWCFRykA3WSic1zxPOkUaROlgntnYDHQG/DbEBbhuOQfgGm5EZpGRXN9osSUxLdb5eV6p3f1DLub0wmoSBqCxgyVPwCvw9qJzs8tMPxC4R8Z7Z0EEVFb/zALFifFctMYbdf/D05kolfm73N0wch5BFu+0IHKpqKs2LOil09d/dazHS01oUKgE/ogu+TUB2/ruOxj4vbtSzZ3gqB+j6GKZWGClo7sqTa4IqwmvDa93b84G4XQetaldCA4xDvlFs/CiXpVobAm6+/JdlzuhUqI8MjIJz0uySeBuOsu75whV3HifmiuWLPOE6yOXdDm9vmoMD/O6pCXNiRchvyxN0wSWjYgWZ2FhQbLyfnHibwuO+9c0KMZPe6PykvZHhoBYmN25QqUOOMP1ypIQH94jaCOQVf/dvnnqx94Fp+GaAKmnRcJtY8CI+KyqfHgICo8BzVV8TxCdPHwLbFPLaNNqWyOS5sjeNu2OCL/2zT3auEWmm0dfO9MHPBqzK9PrM9eOdNveni0+0dkDRk6qrjcwcia+hXY23ZgZQayNGXBlD0woNY7dLLkPNmvYPIMGbY5tJXsWjNKkfus0HvzwE5KaMuRCpy4fSWvzNVRDRGseJEWHWYYZOTE5L32SlWNBmPEPKJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(316002)(186003)(6666004)(6486002)(6512007)(2616005)(478600001)(6506007)(53546011)(66476007)(83380400001)(66946007)(66556008)(2906002)(4744005)(5660300002)(41300700001)(8936002)(4326008)(8676002)(31686004)(38100700002)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0U3WGFjZ1UrRmtENEtoNkxXeVhKUFk1cXRCcXBUU3hSUks4cHdzRmhjMHZz?=
 =?utf-8?B?bmlXWjhReXIwTzNkYm8xbTBzMXdWNmk1bFVrV2JJcjc5blE1V0NIK2pCZFA3?=
 =?utf-8?B?S3pNVlNuMk9ER2JVVlF3UjlTRW1vY3NwaVBkeHZka1hMYUJVY0k1Z2pFT052?=
 =?utf-8?B?TThDUjVhVG5kVExSTjNzZjRBYTVYQ0k2Y2ZycFJVVVFVQUI1VHRJWXBPM0dq?=
 =?utf-8?B?OE9xekg3aFdFaWJQbzNLZVBnTVEwRDh4NFNiV3VWcHVTc3BBd3ZUQUFvVmhD?=
 =?utf-8?B?R1RPQW9IZkFIcXhXcFFlbUY2SGFZUyt2b2JRZXZlQm5TTkQxTUdQUXc4cWRU?=
 =?utf-8?B?OWZDUWdSMVNHTFBqUnNsSTNaMFZGNW9md0w5L0JsZ1NTNUY4ZWNnYy91d3pm?=
 =?utf-8?B?MkFFanFaVXgyT1drV2Y2OWFQNG41L0FsK242N2hzNUZsalhkUWtuWHNiaGJS?=
 =?utf-8?B?NjJuQkFZRElxeHdCeUlXRXczSUJzS2swVkpFZDBUYVhISFc5UmZYQWx4WGd5?=
 =?utf-8?B?Wm8xU3ZseFAwTjJ3c1UySzhSNHFBbVRDY1RzaVlneVJ6b3EwSTRGa2RLVUxT?=
 =?utf-8?B?VzhXQ0J6WjlTNnIwWUg5N0Fjc3Y3ZE0wZkxZb1E0T0dHL3Q0MFVZdmltTnZH?=
 =?utf-8?B?OEM4K1M5UWRFdFhlTEdUeVluSG40Y21LL1pTdzkyVmxzTlEvNGpZWExQRWNH?=
 =?utf-8?B?YU9ObEJ6VGQxaUlFNmxaQUNtaHdLcStScHJXTHpPVGRucmZSd0hKN2RrMW9j?=
 =?utf-8?B?NjVtWGthRm9wK3N1N2k4OVY3N3lxOGVqM1ppUlBpekh4QTQ2VHBnSnFPUUFh?=
 =?utf-8?B?ZzdZb3dYQjY4WEl6U3VodFNRS3YyK3NGTGRWS21pcWxYTi9YTTAzUjc3alV5?=
 =?utf-8?B?Ky9oNTJpNU1WeTNWdTdRa2VTUWtndWFNY3VPT1V1QnQwRk4wUDdCLzJPMTdY?=
 =?utf-8?B?RHpWeDFXZmpMMm1zNk9iL0V2enp4M3ovYU1UdC9oZWlxOUVHQStKT3FkU0Vq?=
 =?utf-8?B?UUJ1ZEdNbzBxZklySWw2enV2akZocllna0RTaTFrV0VDd1VJZ3Z1QW1ZekhT?=
 =?utf-8?B?VFJMOXFLR3ZtY2d1aWxVSGdabU5aRlE3anZHVndUeFlpLzlFa2tsWjNTNENo?=
 =?utf-8?B?d1FGV21tVGQxbndpakJJNnk1NjdrVmRQRHhqY29uakZGYWtIUjhHVVR0OSsz?=
 =?utf-8?B?dlNwMGdqU1U1bkNjenYwellvb052eWFLUTdiMzJKQlF5Rko1TjQrbHF2TVVi?=
 =?utf-8?B?eCs4UEZjeTZOVGFCSGI0TU5VZ1dQSlpvT0JnZk1vKzk1MDFudFpiL2d3TUU3?=
 =?utf-8?B?NG9FMlpzSzF0K3UzaThhcWpib2VYVEYzc1ZYVEVmUU81TllteDdNalVQOThO?=
 =?utf-8?B?NllXWmZic1VxdklEVVVvRDFDSWE5dzczY0xVWTdGNUZoK3RuelJXNStaeFJp?=
 =?utf-8?B?aXFIWGFkWWVYc2diWWVxUk9zQjBkNnFOTE1MRmFvd01uVmo2dVZtTENzL2Jo?=
 =?utf-8?B?VFM4MUliNFFCMUdSY2RXUHBkdlZCWndEcExrRzhwWXN5ZXltdUJPcmtiOThh?=
 =?utf-8?B?OFdYS2tLUENWU2Q1b3hVQlJkWTFxZmVOYXN5d0NDWTZsSkZ1WFBHcHRXYm5S?=
 =?utf-8?B?bkVRMmNVV2lvQ1JBR1ZMamxNdTZLbzRvOU01VVN1ZmpPVVV4RE03YzBMTjRC?=
 =?utf-8?B?K1lESHlvcEZkdkdrWTBlSEU2Mi9rSzcrK3V6Q2lxNTgyQ043ck9GVEtkOTBr?=
 =?utf-8?B?S1R6Z3B3YVRVRTIvZDlSbGt2dVJyRkg2TEVmNkxmR1RKUUVZSzhqU1VuVU9O?=
 =?utf-8?B?VFkraHpRWkhNVjRRcmNna3V0ZENMR2RHT25wUlpsSWprZHNWT0V2VmtQbm45?=
 =?utf-8?B?azRHekhXWWF5MGU3SGpZOUFaMWV6WUdFYWo5TDFYZDRlZG9NeUVtYmxtNUpR?=
 =?utf-8?B?VDhPeU9yMzYyZElabzg1amNEQ0dkZkVsYTJQSTYzRDVZS0ErTXVqR1VicSt3?=
 =?utf-8?B?U2JSWmpTc0tHSk50eXIrN2FXMnNQaTVLY2xqcDdRRUJ6RzdlU05yYlVXS1Bm?=
 =?utf-8?B?R3paU1JwRmdyVEU2RzVSV2ZsWnZhbm5KSHFYclAxUlVNNXN5SGpvR2FVaTIr?=
 =?utf-8?B?RXRjNjFDN2NNWGpPZWlyRXRUMGRmRmZDOFJTTVhMeEloV1hzUFdNdzU5WnRR?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e161a5-5159-4f99-ea6a-08dae06353fa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 19:17:24.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka3ekzmDnBM+GIbyfS0GReOl93voTQfcWeLU7PpJm6V0IqWy7VIFlZayhsrjHYBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3787
X-Proofpoint-GUID: Qdo1giWG1meHVi2i4c262ro2nxTeyIWd
X-Proofpoint-ORIG-GUID: Qdo1giWG1meHVi2i4c262ro2nxTeyIWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_09,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 6:17 PM, Eduard Zingerman wrote:
> A simple program that allocates a bunch of unique register ids than
> branches. The goal is to confirm that idmap used in verifier.c:check_ids()
> has sufficient capacity to verify that branches converge to a same state.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
