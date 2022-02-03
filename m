Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8546D4A9120
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 00:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiBCXYD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 18:24:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60288 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355643AbiBCXYC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 18:24:02 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213NFUsV032643;
        Thu, 3 Feb 2022 15:23:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G7oBH+d7M5k4cToQdvjUSgo08/ay709lYM26Zxt2qO8=;
 b=CR60X8Hx3uFr+LjezNhtz18Ra6J0csKsQnHy45UDEkZbLfGpdCh8ROZBpFGmnVT1izWY
 YJFeAyl3DNgfXdJHo2/sBhUseGnygMjll3cB3kDta9Noh3DtLG+MH+DP92vuICcH4mKp
 TeNhF6YQWhSOIAdnhTEqW32TZBiHxl+FNU4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e0j8btuyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Feb 2022 15:23:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 15:23:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUsZ31TLd3kLWIaZKQVZ4nuKuz4iOD9tO9vhZSszYDbZy+eQ88aiQ1zCw7SnJCQ98d8wk7Jbk3RVKPA16Yov/ny96YPPU+IALtgVBspcUEQ96sWH6JMAeVOgaEObX0lkoZsGJigH/Ld2ytOiP0GarMsf6V0nXZwZ5nMHYosVOCcKHJTeKD+W9YaWJV1DkSSvBYQHdaqhiQsBa3dzAT+FlcnIVNl7jfFG1UTFE+oewAELYV7foonyFj2IDtBvUVpPjH7tXYQlu1aZ3im8RF9Qu6vNnJrRArUdd3ym5/yZqLV9xsQZcIx2Kso04RFLP+vfT9c2KZeEcwEnp/IizXBElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7oBH+d7M5k4cToQdvjUSgo08/ay709lYM26Zxt2qO8=;
 b=UZ7bfBesqqyjvLRCjomN6vCs9YD4arHYaZM2TbRT/6MrKropjFa7y/MxYl5CHsCL7bGsU6Uc9FiqQM52g1cxEmQm9UV3demvWTulInpE4osqVcH6FYhMr8gF5Cig/I3vbvY9VlnYTixfWP/nkwCcuY+OsWbwpenBR0TpPkxIFqTgCjx+KbDfRQqkgvfgquqTh37RRZbcfVe8tjjXP+iXkL7n3eZknJiZotY46NOHv5CslVJprWKiY88OOd7Npsit+2CwwzCMWvSZRFoV+inmJh2hcC75lsHjWilxp+LqcOoflYdDiaM4jAswsG0BGnLjih3BVT26/OAcL9igb36GPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2970.namprd15.prod.outlook.com (2603:10b6:5:13d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 23:23:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 23:23:46 +0000
Message-ID: <76980aa7-10bb-979a-62dd-615621c213a2@fb.com>
Date:   Thu, 3 Feb 2022 15:23:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next] libbpf: deprecate forgotten
 btf__get_map_kv_tids()
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>
References: <20220203225017.1795946-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220203225017.1795946-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b8fb21-3461-4e57-566f-08d9e76c39fc
X-MS-TrafficTypeDiagnostic: DM6PR15MB2970:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2970B043E032AFB814B76E11D3289@DM6PR15MB2970.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0yEFrxynasHZ0APRBp8kyyikDSsxjq5nRA0AZ3f67PUMvvJZgqRDLU2VZG712iqhQ+Ah9SnvYfRMgATWQ4aUNWNfnWJFo8FaEG5AxZKg7LaSFvPKHLQHBwDorm9wZZ8+nXhiIobhsfLyWZ4tcTACJhtMhgDs6WDW1U4LdpOMUuT/0FE2id0I6Xit2nEaQX4mQFttyYjMpneOdKEqGzj/xYM3khLPWxlLTkqWRuwGJXBxSrJJjU0F5I95H3KFUfH2HhOnh0X2jEb6xHUPf7rxG4CKK2L81mjansg1fKdlzE1FGrQHMIb5X3KJuwsdcxy7CKkH1yQz1sYe7FtcL3Ak3+fDDwdbwBjgQvSRMu7+O5VCkTAJ11FlhuavkRpK91N5x9F+4RJm2TcfZBzMclKl3xWkqjdi+yqYRmfy7LFQoCqENs/n0UO6D1E+T/URF7uKNSXkJLhdzW68EEETXzy9ELNijLoQ+ojC06XtHTUsuD0/phD8OarnL+9sb3VCpdqXQHKDiO9ejwtTncxeZCQwcvYSjn3LhtXMD1x6Utr6jIdfxC/S9s5E3u/MTPdsVNR0aOHHf3LGbQR6SRHtAnXH8hP/JLNPEuz+WG50Z6Q0GwYFs6pF4Ri2oU5t1i9xl63Y7bVf1nWf7/VxhEM76Tj4bnyVEbWMP7I8fgK32CybSLE2lwhfsbpcjIxAbx8QdfRd6ZrMd1S/iOQ8CrKw+NsgrPulPlqbuU1Qc8yDA0DhAz8oP34IhSCcIEaTSRSsiGdUn5KbgGPJ0A1dbvgw/Emq9CHiS7ebpMJ3bYOR+v62/3bOrSjxxRYT+TFy3rM+oszMXCbeR+oX1+YGoIlGzIM690ZbFTe+p6crPLScuZSYVUKp+UTrFSNb0GgHVQxKalBnXzwAXeWgk7xyWeFy4CUSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6506007)(66556008)(66476007)(6512007)(6666004)(508600001)(316002)(6486002)(2906002)(86362001)(966005)(31696002)(36756003)(31686004)(38100700002)(52116002)(186003)(4326008)(53546011)(8676002)(8936002)(2616005)(83380400001)(5660300002)(4744005)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXFXNE1wZmZHSWVKdHRGLzV0VCtveGd0ZGMzMzJGbTE3VWpaRWtvY1BFL1ZE?=
 =?utf-8?B?L2wrbHIyRy9Tc2tDbGJDT1E0cmQ1SFA1R05HRjVlZnZ3OWx4M3ExeXRlNWZ3?=
 =?utf-8?B?TVFjUjZNR3h1MDB0Kzl6dkxGNFdmWG0xSm52QUFPRVdjeFRoRFR3SnVDMWhi?=
 =?utf-8?B?Y2c1aEx6SVlPUHZKUTdFbjhZMk1KSStzQ3JYdEF1Z1JJQ2dwdU10ZWdZbHRn?=
 =?utf-8?B?Y24yem9jRzhXNDJuTXF0L0V6cXdsbU5Fc0oyS0dLNXZXdG83TzQ1TjJJSU9D?=
 =?utf-8?B?VzdQVGlnM0NvVW5OWmg4dmFjZnErdW0rUDNQZTJkeHBFOTlKMG9kOURtS3c2?=
 =?utf-8?B?eEIzeTJkYVJOanZVTDBBcVM0ZzZIM2xOb1BtcWV5SXFQM0xxYzZ1MlVVNWxi?=
 =?utf-8?B?akhIOWlCVm5pTzBCS2VxTlFQOCtjUGZCUkUyTzN4Rk1lZm9BN0RybzBPL2pq?=
 =?utf-8?B?RXh2dVNpemZiWGovS25QOFBaZ1FITFYwcVpuUW94NXRjekhBRE1zSGJJQ3hO?=
 =?utf-8?B?dVIrRE5ISkwzZmF0VlZqZkpIQ1pXMk5JWFRGNHk2emlIdFgwNlhqS1BiSmtL?=
 =?utf-8?B?UG1Vb2VzUUF3UllwTVJIU09wOGw0MWp4eEhndEdaaHBRVGNvK2t4VEloNXJU?=
 =?utf-8?B?Wlh5ajVwYkVXZkJuM0dCUWM1eVN3OGJRN0hXOStJMXJBemZ5MWRIbFhrZ3Jy?=
 =?utf-8?B?YlR6MHVyZHBMc2NMb3FNaTdqb0VlK3FJaUVORU1CZG1PZ0JnSGZmVkJueWdV?=
 =?utf-8?B?TkI3dlJXMEg5L09aTkxrQWVwYVIwbElKY0w0YndwYVJhWFJKb0puNjNVNGk2?=
 =?utf-8?B?alVlS1Q2OUx5YVA0NTdLb0dwNE8wV0pOQVcwbnZMZElZYkxXQWJZWUpMOU5T?=
 =?utf-8?B?MHpXTVJlWTlONEZzL1FwWS9WbTNMT3pFWktDV0x4MWxFcGMvQjVIVUQwVTVF?=
 =?utf-8?B?NU50cXI5VDhld3JydnRadWFzQ2xtVkQ4U1o3OGcySU9vOUlZTFRVRTVaRXEr?=
 =?utf-8?B?cWtMUzhEU2w3V0cvYklObERJb3VwSmxLVTJ2ckFsOXduaTduS3p2OEpndVhy?=
 =?utf-8?B?ejFmQmtrYXJKaFJUeDB0bXkzK2o0SURSU3dOdUYzMTRxT1dVSGtGbkIxbnVI?=
 =?utf-8?B?NGFGTnIyVS82aFMvNnUrb2VsVjFKTlp2eVlQL3lnb1E3VUFEZ3dFRzJYTEJG?=
 =?utf-8?B?MlNPU1FpTjJ4RzBNd3F3RDRZZGlMSDBra3dGZmRRcjlkWnpYYVNPMzFVcitL?=
 =?utf-8?B?SUtQcFBPTjNjUUVpNHhTRVR2LzVIRmJTc2Zsa3RTVUF0ckx4QmZZb0hlcFI3?=
 =?utf-8?B?d2pLTnhseFFkQ3pkUG84akhOZ0crUzN6TVZuNTE4WEJRVkVrM0FjWThRZHds?=
 =?utf-8?B?NmszUzduZlRXS3hkakRQVzdNNHZIYmR5SmI1MHd5RzhhTGc3eTJNSnd4dGpN?=
 =?utf-8?B?TzMyQngvS01vR3djditONktqeVhaVlB4NGFSUWRSSElIbEVlVVBhbnkrME92?=
 =?utf-8?B?NTVEQTg5TzFyNzJUelV2SGNMNnRidFRiSU5kSStuTXozNHRqMy9VYXJHbHRr?=
 =?utf-8?B?OUY5T2JSOElKZWJUdDAzdWl0TDMvc0VYQmVYMllyUU5DQ2JZN0dxbkRMRWF5?=
 =?utf-8?B?Y2dJdzJwU0hSbDBGb1NSRE52WU9DZ3ppTmV1OUIzWVpOaldydkMyemdvWE5k?=
 =?utf-8?B?aEZLOFNsaHRzaVoyeGdsMnlzWFZpcDNTZ1hCWnlVd0RqaitFUUpjOUpWNVV2?=
 =?utf-8?B?Zm1QS3Zsck1iUVdjd2p2NC9oSUp2TXdqTVVmK0o0WWlRMU1PZmkvMDR3dzQz?=
 =?utf-8?B?T2UyeCtHdzB5OTJQM1ZqRjRROXMwL2lScmQ4dml3TS9WM25TWm1JK2hMa0xS?=
 =?utf-8?B?TkZ2Nm9ORXltVVpObmFZNkRIWkttNDNhMjF2NFphd245aHlQLzVLSldJdytP?=
 =?utf-8?B?djRKK2JISUwwMWhWTXhCQ3RKMjE3N3ZPMFk1OEhPNXlwRWsyeWtLNzI4eFo2?=
 =?utf-8?B?Y3lsYUQ1aFZKQXhya0Z4cElzdnZ5emkyUGlGaUdiYXdZa01IQnc0YUpLekZ2?=
 =?utf-8?B?Q2U3Y1hHQ1N5cnBVQUtXeDlaNzA2bUcydlR2ZGpSQ1l6U1VyN3B4YUUybWtJ?=
 =?utf-8?Q?QuruWCPR8Lb9hjI4Moa+kIIpU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b8fb21-3461-4e57-566f-08d9e76c39fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 23:23:46.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBKu6q5cA0oKQplGhtWk/MH1u7rMGpIRQADQ9tHMrOnyMDfGnrx5IcvrtPNxUQsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2970
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 4hhRu_G5FUlTVOdGZ1Jp9tMOrlZMFx0_
X-Proofpoint-GUID: 4hhRu_G5FUlTVOdGZ1Jp9tMOrlZMFx0_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 mlxlogscore=829 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/3/22 2:50 PM, Andrii Nakryiko wrote:
> btf__get_map_kv_tids() is in the same group of APIs as
> btf_ext__reloc_func_info()/btf_ext__reloc_line_info() which were only
> used by BCC. It was missed to be marked as deprecated in [0]. Fixing
> that to complete [1].
> 
>    [0] https://patchwork.kernel.org/project/netdevbpf/patch/20220201014610.3522985-1-davemarchevsky@fb.com/
>    [1] Closes: https://github.com/libbpf/libbpf/issues/277
> 
> Cc: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
