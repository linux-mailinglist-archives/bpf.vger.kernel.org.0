Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5396017FB
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 21:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJQTq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJQTqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 15:46:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021622A250
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 12:46:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJPLwX011827;
        Mon, 17 Oct 2022 12:45:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=nrceQ2RXkScTZYe7Ow2nJH/rw9TjH4gwWfWisrFkeFI=;
 b=bMOnTkofPDmf0G9BxdEpsLATl9aGAltjxfnTRKiAn93xrYwsZNr7ZCHV96h89Sl6dLAv
 34Dp4eNP62EkuEDCns4O15SYsazqnOJVTywkyKttK5S5MVbeGj7NzXOX7QagiSBQ+lGA
 UOExtF94bw8zy0MJaBzspOZEiia9yg0RHgJsIv5JunMa/5Rikb9EnqaTXIgA8fL3geAj
 /F0DJjuaoo+k6eLt2EF3Rc2TU9r03KhoRRcqsyiDBi3LNrYkVvqzhglaZWv3iPspd9gn
 o2dbEZPxHXKeBpCl/E/MqlDFlluL1sWFYI0NOfpo/4iEm8WxmQSiBYNao/GR+fPUKJ7Y UQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9d1jg9nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 12:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPMrPG5TP1e+OUQSo16SPorHL/ewSB0N+jW7+63H4AUcDevvZDezNBKdSd+xvTNEGT3fLTpyssC2GDA3foTNwsEsLxXr9OsCMXlWX3ny4zo6lILmc+Jkq5p2I6rcU4LXDrwnUy/VKQ91lQcDBFhAvvjAXz+Uj2S+iI989i4+1p/wFYJjZbnXlWgdyDzMjGHwemN9sUd1vuXFAbBDFHW9BA4Fy/iONIzsGKAf5XLyOem6DT/8FQE50Fc56N5iv/5E8+k00QOLUjdg+Xha14wHe9diysokTt1KHXG9T+SK25Nxj+nXshFEkP7KBr041IagEOPN0ziYjhRPtk1r2gCRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrceQ2RXkScTZYe7Ow2nJH/rw9TjH4gwWfWisrFkeFI=;
 b=R3TVZGjEAAaVs58H+IE5DrJ3rpEqzFnNMyRBQH9PI9p6zUu0FPKa6iQfXTFJWAcWQEEfcsb9w73TL3Ba9grUim484gJHUk8QUCxnNBacwO14B/hCl6hln1ulLKXqta12hTDT32qQBx9V9fQwbTFMWDvob9LruHf1JYvRPk+3y6sDTwUIJpnaOiYm6l1isMQNwvzL/Wg2c663fqe1UY77HeAUPtmWSkxIRianfUHg2OIIhpucTifOdfAb44BZZcqyq47lAImALXyyTtXKqt5Ike9xW+AuEHHkdbiHGt+ZCPlG1rKu/80y+xoDziqeoeyyrjvNeB4N/z2FtIsjZxPAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3358.namprd15.prod.outlook.com (2603:10b6:208:fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 19:45:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 19:45:49 +0000
Message-ID: <6ce7d490-f015-531f-3dbb-b6f7717f0590@meta.com>
Date:   Mon, 17 Oct 2022 12:45:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com>
 <Y02b+ZSW6NcI2dDV@maniforge.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y02b+ZSW6NcI2dDV@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:36e::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3358:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d707bf-806a-42b8-7bd6-08dab07830dc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8ZlnIAGcWOY6yN5tYczDGwVbzR3khhI+frfRhRMTtunUY2QJ1tHI2bhWZ0tpVWMg9Q4pWGP7pbA1rtq/GA0C5C2yRbfYlgaMN7zgz8cGvL2m/Ba1M0Kyry3za2Lkuy250GsuuHFmhEMfLOI4doHRPzKf62ICr+tUPxA7FsG6YL2Ind3XmnpIBs1G9SGtG36gv5gOlzzLCV4f/UGh6cPpunjyO8T+CuUhu6typdD+3zvoM+FcUMi57nQvAEcGsAS7SpaLm5MOSgNmf72Ot/o6tYVwqUeLmnTrCPLqldlNtXawmrhhYOk+GY3DQgkEagnR6kpr9Sa/Uc70AhQienrvYNmjwqtqp3CQobPK+1QyHYjBBNCtt/0OOfsfDUCf7ko9Fd1lDqkC9YlxOpvN88bpt84S2+SUXXQVa6EMryg7QSxp6cWahB9qBDMnMfHrhQoP3HFazPj3Vg7kprmfdxjEl3YbxD3NOT+95cQTFdgpGyGO7+GhYKqXizwDlki0r6jSA6bgksQW8y+vdVIhUxlplhfU41Qtilp8V8mxP690oWNvZRgiMuxR9cJWU72qw73M9ONjg8TPWFaEdFWHnZR2sod015U/3L2ptDnrJ/zGNqWVcaJ5HderzbkE850A8aAqJy3fJMaIKz9Qw39KTC1//fk90WYRnOflAaWZXB+8dzLJw+30S3uIber/Mra8LFJZaDbtH7AZceVHRJ+OVlo7rXh9QkK5QUFkp0gUdTIQDPPAKDGDSEYeTtH9Ui36nZaiehVg8Pn2H+2//mmh4OLrZDsJaNI/A/29V+qPlMaLz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(54906003)(110136005)(316002)(8936002)(5660300002)(2616005)(186003)(6512007)(86362001)(30864003)(36756003)(2906002)(66556008)(66946007)(83380400001)(6666004)(8676002)(4326008)(31696002)(66476007)(53546011)(6506007)(41300700001)(31686004)(478600001)(38100700002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajY4VEkwN3A2VjRMSnlhdzNXazE2dXJvZkhySmZuRVB2Vm9IZUQ4VkZ2ZDZs?=
 =?utf-8?B?VXRrQnJHT3R2YzZvdFdGai91MENlY1oyZmhmNXZHbjVzb1Y0WC9kMEFPTkkz?=
 =?utf-8?B?N3M4cGRvd2czckluWjc2RFp2NkRQSlluTElYSUpUQjZPWjd4azAwWDlTckY5?=
 =?utf-8?B?d0lxMHhlTWg1Uk5aYXM0cURETFAxQ1BXdVVKdFVVdEVMSHdlYTVPSStXZktB?=
 =?utf-8?B?Qit4MlkzWjBtMGFZVDdaNURvejNGTzlXNE5OT0FENDQ1RWlqaGJlcTU4eTVw?=
 =?utf-8?B?L1U4TkJCak9BSnU0cFFGNnR0UG1Yd3RJdEt1NGVvV1dJeG0vUHloTWtzWXRT?=
 =?utf-8?B?REFmWUsvZkU1V0k0VlBkSTFjMGo1ck9vN0JxVnkwd1UrbUpBUTI4dDhuL2lR?=
 =?utf-8?B?MHZ1cUJkVGpnR0x5QVZjbHYxRG5RR3NnZEZySitxOHJ4N0lTbncvY0UxMFZq?=
 =?utf-8?B?akc3dzYvc00zdmpjdjd6ZHZvVDVJUW5UZzhQcVQyY0NIWVlQWS9KUXV2RktS?=
 =?utf-8?B?cG1vdDR4a2lkenJKOFRNM2xXaklod2hnNEI0Rm40aGJKMHhNbytodmVXckVZ?=
 =?utf-8?B?bjBWK3lubjBYdkhFNHc2UDZkcEgxOEhTTTdvbUJ3RUFqL1dCVDU2WlBZeEc0?=
 =?utf-8?B?Y2RCODlXZFJBSlJxQU56d1NpU1NNVUE5ZFIxOERjVlVtZmxvdTkrM1Z4WHRP?=
 =?utf-8?B?RGE5WURucXc3cEoyUEwzZm01ZXVraTB0UklzdWYxQloxV0ZVQmdwK21UVkFo?=
 =?utf-8?B?bE9sUWtYT0c5aytleGsxWnM5eFRTV2R3K0xycWFaRER2WlcyUE1aMmJNalkv?=
 =?utf-8?B?SVJkVDEyTm90U21zbDlJdGFSTDdzTHpWRHNZN2QzN3hOaWZtWms5THFDc3RS?=
 =?utf-8?B?ZnB5cGJ1OXVXa2xUMUpWSnpzdHBpL0RmcmE0dFZPK2pCZS9RQVJobHRuMVBL?=
 =?utf-8?B?bk11YktMVUdrR1BLQmhIM2Q1TFBTcGtVYVBhSVNmaXpSSklya2FlcWlFOE8v?=
 =?utf-8?B?ZmlpZVpzLzRLbkVibE13c1J2dzVFSitPZWwvcXVjMnR0WlZxd0liWUVrdDNW?=
 =?utf-8?B?RkdSRzk5NVNwYUlwaTBvd0IzWDFHZjdSZWtCSmdRcGNaWjNUalhIa1EyVWdP?=
 =?utf-8?B?V2k3WnIrT2hHZWh5R3RQcmhRK1Zmb1NVWXErV25lSWoybnJkNHBDZXdWOERo?=
 =?utf-8?B?NG1SNXovb3p6dDdYcFJQZTZVTFdGQkNscHFGeEZtSUxGOFJXYUdoOGRCU1Rs?=
 =?utf-8?B?S0E0eVg0QU9TbGpqVGRpSmJBbGVtV0d6WnN0TmRMTzRDQnE1VU9DcHVWdUww?=
 =?utf-8?B?ZXoxaVBIcFJiSGcvUForYmx6RjJuTHMvOWFybFlUcUxLOXhVeXpCUVBuYisw?=
 =?utf-8?B?ekJwa3NIVVhpSE1ZRUxpRmQ3ZVpFNG5hMXdoWXREdlhzVDJBR0N0akZUclZV?=
 =?utf-8?B?T2p0dzcrTkFiZ0dpcXpSV2dnZUV4V3RMcUJsUXFSZGxwR3NiU2tPSHFOYnRt?=
 =?utf-8?B?MnphTms0VzI5WjVWSWNtMWR0OGV5UmxoUEdlZVQ2RFdVMVZqaFJ2RVFXenhB?=
 =?utf-8?B?SnQxNStWWFBoeUxHNG5LV1V3NUFOeTByVzNSbmV0SVNYbzJVOGlCMmRVK1ZR?=
 =?utf-8?B?OUFsMjNpK3VHZmRBeSsvSll3S0YvTEhQRzJsZlVZQmFrZlpnczl5VlJqbkts?=
 =?utf-8?B?bHprdy9LTU1aZmJYYi9tbCtqM2tvdXpnRlgwa0FNa3VTUlJEaTZWaXBsMHVx?=
 =?utf-8?B?NG9ZMGNmSFE0bU90MWhOV0s1S1hCdExKTkUxZWlqRFR6RmJMYnBmTmNpWEdh?=
 =?utf-8?B?SDhTb0lWY2g4NStCNjI3cklBc0FxeHp2ZkhmUlBsTEpjVnNUYThTdWQycjlH?=
 =?utf-8?B?VDk0VzZFTVF4WnRDT1JEVGF0ZmozMHU5ME1JcFJmNlkreWRCaGF6b2VWWFhD?=
 =?utf-8?B?dnlzTzVMVkpMaDlnOFk1YzZ0MXBIUXpmclhoeHVXRmt0c201a0FIS00veDd5?=
 =?utf-8?B?d2s1RmFlWnB4NktGQS80am5NcXcydUhtN2JsZXl1ZVM3V0xrUjAzTlpuTFY2?=
 =?utf-8?B?eWZJRFRubXM0RDgxWTJ0SGNXY25FNjVHYWxoaS9tNWJvemduVG1sNzRGRU0r?=
 =?utf-8?B?bDIzZWdKQTBXZDVkeTdxamt0UkpEWHgzbUxUZlB0ZmZjTmtIVnNnUGZQejFs?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d707bf-806a-42b8-7bd6-08dab07830dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 19:45:49.0228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja9dy5iiOpAjTA8gJyXKLiI5zlN06n+RaHJgCap6epga0Q9INj4gqFOpyHU3j83h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3358
X-Proofpoint-ORIG-GUID: walr0KVYrnn0crZ_lMX1IoT5qu-p7Omh
X-Proofpoint-GUID: walr0KVYrnn0crZ_lMX1IoT5qu-p7Omh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/17/22 11:16 AM, David Vernet wrote:
> On Thu, Oct 13, 2022 at 09:56:30PM -0700, Yonghong Song wrote:
>> Similar to sk/inode/task storage, implement similar cgroup local storage.
>>
>> There already exists a local storage implementation for cgroup-attached
>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
>> bpf_get_local_storage(). But there are use cases such that non-cgroup
>> attached bpf progs wants to access cgroup local storage data. For example,
>> tc egress prog has access to sk and cgroup. It is possible to use
>> sk local storage to emulate cgroup local storage by storing data in socket.
>> But this is a waste as it could be lots of sockets belonging to a particular
>> cgroup. Alternatively, a separate map can be created with cgroup id as the key.
>> But this will introduce additional overhead to manipulate the new map.
>> A cgroup local storage, similar to existing sk/inode/task storage,
>> should help for this use case.
>>
>> The life-cycle of storage is managed with the life-cycle of the
>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
>> with a callback to the bpf_cgroup_storage_free when cgroup itself
>> is deleted.
>>
>> The userspace map operations can be done by using a cgroup fd as a key
>> passed to the lookup, update and delete operations.
>>
>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup local
>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is used
>> for cgroup storage available to non-cgroup-attached bpf programs. The two
>> helpers are named as bpf_cgroup_local_storage_get() and
>> bpf_cgroup_local_storage_delete().
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h             |   3 +
>>   include/linux/bpf_types.h       |   1 +
>>   include/linux/cgroup-defs.h     |   4 +
>>   include/uapi/linux/bpf.h        |  39 +++++
>>   kernel/bpf/Makefile             |   2 +-
>>   kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
>>   kernel/bpf/helpers.c            |   6 +
>>   kernel/bpf/syscall.c            |   3 +-
>>   kernel/bpf/verifier.c           |  14 +-
>>   kernel/cgroup/cgroup.c          |   4 +
>>   kernel/trace/bpf_trace.c        |   4 +
>>   scripts/bpf_doc.py              |   2 +
>>   tools/include/uapi/linux/bpf.h  |  39 +++++
>>   13 files changed, 398 insertions(+), 3 deletions(-)
>>   create mode 100644 kernel/bpf/bpf_cgroup_storage.c
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 9e7d46d16032..1395a01c7f18 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2045,6 +2045,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
>>   
>>   const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
>>   void bpf_task_storage_free(struct task_struct *task);
>> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup);
>>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>>   const struct btf_func_model *
>>   bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>> @@ -2537,6 +2538,8 @@ extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>>   extern const struct bpf_func_proto bpf_set_retval_proto;
>>   extern const struct bpf_func_proto bpf_get_retval_proto;
>>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>> +extern const struct bpf_func_proto bpf_cgroup_storage_get_proto;
>> +extern const struct bpf_func_proto bpf_cgroup_storage_delete_proto;
>>   
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>> index 2c6a4f2562a7..7a0362d7a0aa 100644
>> --- a/include/linux/bpf_types.h
>> +++ b/include/linux/bpf_types.h
>> @@ -90,6 +90,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
>>   #ifdef CONFIG_CGROUP_BPF
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
>> +BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE, cgroup_local_storage_map_ops)
> 
> Did you mean to compile this out if !CONFIG_CGROUP_BPF? It looks like
> we're using CONFIG_BPF_SYSCALL elsewhere, which makes sense if we're
> keeping CONFIG_CGROUP_BPF for programs attaching to cgroups. Or maybe we
> should put it in CONFIG_CGROUPS, which is what we use when compiling
> bpf_cgroup_storage.o and the other relevant helpers?

BPF_MAP_TYPE is defined as

#define BPF_MAP_TYPE(_id, _ops) \
         extern const struct bpf_map_ops _ops;

so it should be okay whether it is guarded by CONFIG_CGROUP_BPF
or CONFIG_CGROUPS.

I am aware some helper related codes/switch-cases are guarded
with CONFIG_CGRUOPS and I just added my helper there as well.
But I will double check that CONFIF_CGROUPS && !CONFIG_CGROUP_BPF
can compile properly.

> 
> Also, would you mind please adding comments here explaining what the
> difference is between these map types? In terms of readability,
> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE and BPF_MAP_TYPE_CGROUP_STORAGE are
> nearly identical, and adding to the confusion,
> BPF_MAP_TYPE_CGROUP_STORAGE is itself accessed with the
> bpf_get_local_storage() helper. I feel like we need to be quite verbose
> about the difference here or users are going to be confused when trying
> to figure out the differences between these map types.

Agree. two very similar map names are confusing. I plan to reuse
the same map name BPF_MAP_TYPE_CGROUP_STORAGE and add a map-flag
to distinghish two use cases.

> 
>>   #endif
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 4bcf56b3491c..c6f4590dda68 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -504,6 +504,10 @@ struct cgroup {
>>   	/* Used to store internal freezer state */
>>   	struct cgroup_freezer_state freezer;
>>   
>> +#ifdef CONFIG_BPF_SYSCALL
> 
> As alluded to above, I assume this should _not_ be:
> 
> #ifdef CONFIG_CGROUP_BPF
> 
> Just wanted to highlight it to make sure we're being consistent.

We should be okay here as
config CGROUP_BPF
         bool "Support for eBPF programs attached to cgroups"
         depends on BPF_SYSCALL
         select SOCK_CGROUP_DATA

But I can change to CONFIG_CGROUP_BPF.

> 
>> +	struct bpf_local_storage __rcu  *bpf_cgroup_storage;
>> +#endif
>> +
>>   	/* ids of the ancestors at each level including self */
>>   	u64 ancestor_ids[];
>>   };
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 17f61338f8f8..d918b4054297 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -935,6 +935,7 @@ enum bpf_map_type {
>>   	BPF_MAP_TYPE_TASK_STORAGE,
>>   	BPF_MAP_TYPE_BLOOM_FILTER,
>>   	BPF_MAP_TYPE_USER_RINGBUF,
>> +	BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE,
>>   };
>>   
>>   /* Note that tracing related programs such as
>> @@ -5435,6 +5436,42 @@ union bpf_attr {
>>    *		**-E2BIG** if user-space has tried to publish a sample which is
>>    *		larger than the size of the ring buffer, or which cannot fit
>>    *		within a struct bpf_dynptr.
>> + *
>> + * void *bpf_cgroup_local_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
> 
> I think it will be easy for users to get confused here with
> bpf_get_local_storage(), which even mentions "cgroup local storage" in
> the description:
> 
> 3338  * void *bpf_get_local_storage(void *map, u64 flags)
> 3339  *      Description
> 3340  *              Get the pointer to the local storage area.
> 3341  *              The type and the size of the local storage is defined
> 3342  *              by the *map* argument.
> 3343  *              The *flags* meaning is specific for each map type,
> 3344  *              and has to be 0 for cgroup local storage.
> 
> It would have been nice if, instead of defining an entirely new helper,
> we could update enum bpf_cgroup_storage_type to include a third type of
> cgroup storage, something like:
> 
> BPF_CGROUP_STORAGE_LOCAL
> 
> That of course doesn't work for bpf_get_local_storage() though, which
> doesn't take a struct cgroup * argument. So I think what you're
> proposing is fine, though I would again suggest that we explicitly spell
> out the difference between bpf_cgroup_local_storage_get() and
> bpf_get_local_storage(). Alternatively, do we have any intention of
> deprecating the older cgroup storage map types? What you're proposing
> here feels like a more canonical and ergonomic API, so it'd be nice to
> guide folks towards this as the proper cgroup local storage map at some
> point.
> 
> Also, one more nit / thought, but should we change the name to:
> 
> void *bpf_cgroup_storage_get()

Ya, I plan to use this in the next revision.
Basically bpf_cgroup_storage_get/delete() can be used
if flag BPF_F_LOCAL_STORAGE_GENERIC is specified.
If the flag BPF_F_LOCAL_STORAGE_GENERIC is not specified,
the helper bpf_get_local_storage() can be used.

> 
> This more closely matches the equivalent for task local storage:
> bpf_task_storage_get().
> 
>> + *	Description
>> + *		Get a bpf_local_storage from the *cgroup*.
>> + *
>> + *		Logically, it could be thought of as getting the value from
>> + *		a *map* with *cgroup* as the **key**.  From this
>> + *		perspective,  the usage is not much different from
>> + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
>> + *		helper enforces the key must be a cgroup struct and the map must also
>> + *		be a **BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE**.
>> + *
>> + *		Underneath, the value is stored locally at *cgroup* instead of
>> + *		the *map*.  The *map* is used as the bpf-local-storage
>> + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
>> + *		searched against all bpf_local_storage residing at *cgroup*.
>> + *
>> + *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
>> + *		used such that a new bpf_local_storage will be
>> + *		created if one does not exist.  *value* can be used
>> + *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
>> + *		the initial value of a bpf_local_storage.  If *value* is
>> + *		**NULL**, the new bpf_local_storage will be zero initialized.
>> + *	Return
>> + *		A bpf_local_storage pointer is returned on success.
>> + *
>> + *		**NULL** if not found or there was an error in adding
>> + *		a new bpf_local_storage.
>> + *
>> + * long bpf_cgroup_local_storage_delete(struct bpf_map *map, struct cgroup *cgroup)
> 
> Same question here r.e. name. Is bpf_cgroup_storage_delete() more
> consistent with local storage existing helpers such as
> bpf_task_storage_delete()?
> 
>> + *	Description
>> + *		Delete a bpf_local_storage from a *cgroup*.
>> + *	Return
>> + *		0 on success.
>> + *
>> + *		**-ENOENT** if the bpf_local_storage cannot be found.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>   	FN(unspec, 0, ##ctx)				\
>> @@ -5647,6 +5684,8 @@ union bpf_attr {
>>   	FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)	\
>>   	FN(ktime_get_tai_ns, 208, ##ctx)		\
>>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>> +	FN(cgroup_local_storage_get, 210, ##ctx)	\
>> +	FN(cgroup_local_storage_delete, 211, ##ctx)	\
>>   	/* */
>>   
>>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 341c94f208f4..b02693f51978 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>>   obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>>   endif
>>   ifeq ($(CONFIG_CGROUPS),y)
>> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
>> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgroup_storage.o
>>   endif
>>   obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>>   ifeq ($(CONFIG_INET),y)
>> diff --git a/kernel/bpf/bpf_cgroup_storage.c b/kernel/bpf/bpf_cgroup_storage.c
>> new file mode 100644
>> index 000000000000..9974784822da
>> --- /dev/null
>> +++ b/kernel/bpf/bpf_cgroup_storage.c
>> @@ -0,0 +1,280 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_local_storage.h>
>> +#include <uapi/linux/btf.h>
>> +#include <linux/btf_ids.h>
>> +
>> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
>> +
>> +static DEFINE_PER_CPU(int, bpf_cgroup_storage_busy);
>> +
>> +static void bpf_cgroup_storage_lock(void)
>> +{
>> +	migrate_disable();
>> +	this_cpu_inc(bpf_cgroup_storage_busy);
>> +}
>> +
>> +static void bpf_cgroup_storage_unlock(void)
>> +{
>> +	this_cpu_dec(bpf_cgroup_storage_busy);
>> +	migrate_enable();
>> +}
>> +
>> +static bool bpf_cgroup_storage_trylock(void)
>> +{
>> +	migrate_disable();
>> +	if (unlikely(this_cpu_inc_return(bpf_cgroup_storage_busy) != 1)) {
>> +		this_cpu_dec(bpf_cgroup_storage_busy);
>> +		migrate_enable();
>> +		return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>> +{
>> +	struct cgroup *cg = owner;
>> +
>> +	return &cg->bpf_cgroup_storage;
>> +}
>> +
>> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup)
>> +{
>> +	struct bpf_local_storage *local_storage;
>> +	struct bpf_local_storage_elem *selem;
>> +	bool free_cgroup_storage = false;
>> +	struct hlist_node *n;
>> +	unsigned long flags;
>> +
>> +	rcu_read_lock();
>> +	local_storage = rcu_dereference(cgroup->bpf_cgroup_storage);
>> +	if (!local_storage) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	/* Neither the bpf_prog nor the bpf-map's syscall
>> +	 * could be modifying the local_storage->list now.
>> +	 * Thus, no elem can be added-to or deleted-from the
>> +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
>> +	 *
>> +	 * It is racing with bpf_local_storage_map_free() alone
>> +	 * when unlinking elem from the local_storage->list and
>> +	 * the map's bucket->list.
>> +	 */
>> +	bpf_cgroup_storage_lock();
>> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
>> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>> +		bpf_selem_unlink_map(selem);
>> +		free_cgroup_storage =
>> +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> 
> Could this overwrite a previously-true free_cgroup_storage if one of
> these entries is false? Did you mean to do something like this?

I will add a comment here. This should not be the case.
> 
> if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
> 	free_cgroup_storage = true;
> 
>> +	}
>> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>> +	bpf_cgroup_storage_unlock();
>> +	rcu_read_unlock();
>> +
>> +	/* free_cgroup_storage should always be true as long as
>> +	 * local_storage->list was non-empty.
>> +	 */
>> +	if (free_cgroup_storage)
>> +		kfree_rcu(local_storage, rcu);
>> +}
>> +
>> +static struct bpf_local_storage_data *
>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
>> +{
>> +	struct bpf_local_storage *cgroup_storage;
>> +	struct bpf_local_storage_map *smap;
>> +
>> +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgroup_storage,
>> +					       bpf_rcu_lock_held());
>> +	if (!cgroup_storage)
>> +		return NULL;
>> +
>> +	smap = (struct bpf_local_storage_map *)map;
>> +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
>> +}
>> +
>> +static void *bpf_cgroup_storage_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +	struct cgroup *cgroup;
>> +	int fd;
>> +
>> +	fd = *(int *)key;
>> +	cgroup = cgroup_get_from_fd(fd);
>> +	if (IS_ERR(cgroup))
>> +		return ERR_CAST(cgroup);
>> +
>> +	bpf_cgroup_storage_lock();
>> +	sdata = cgroup_storage_lookup(cgroup, map, true);
>> +	bpf_cgroup_storage_unlock();
>> +	cgroup_put(cgroup);
>> +	return sdata ? sdata->data : NULL;
>> +}
>> +
>> +static int bpf_cgroup_storage_update_elem(struct bpf_map *map, void *key,
>> +					  void *value, u64 map_flags)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +	struct cgroup *cgroup;
>> +	int err, fd;
>> +
>> +	fd = *(int *)key;
>> +	cgroup = cgroup_get_from_fd(fd);
>> +	if (IS_ERR(cgroup))
>> +		return PTR_ERR(cgroup);
>> +
>> +	bpf_cgroup_storage_lock();
>> +	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
>> +					 value, map_flags, GFP_ATOMIC);
>> +	bpf_cgroup_storage_unlock();
>> +	err = PTR_ERR_OR_ZERO(sdata);
>> +	cgroup_put(cgroup);
>> +	return err;
> 
> Optional suggestion, but perhaps this is slightly more concise:
> 
> bpf_cgroup_storage_unlock();
> cgroup_put(cgroup);
> return PTR_ERR_OR_ZERO(sdata);

Good idea. Will do.

> 
>> +}
>> +
>> +static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +
>> +	sdata = cgroup_storage_lookup(cgroup, map, false);
>> +	if (!sdata)
>> +		return -ENOENT;
>> +
>> +	bpf_selem_unlink(SELEM(sdata), true);
>> +	return 0;
>> +}
>> +
>> +static int bpf_cgroup_storage_delete_elem(struct bpf_map *map, void *key)
>> +{
>> +	struct cgroup *cgroup;
>> +	int err, fd;
>> +
>> +	fd = *(int *)key;
>> +	cgroup = cgroup_get_from_fd(fd);
>> +	if (IS_ERR(cgroup))
>> +		return PTR_ERR(cgroup);
>> +
>> +	bpf_cgroup_storage_lock();
>> +	err = cgroup_storage_delete(cgroup, map);
>> +	bpf_cgroup_storage_unlock();
>> +	if (err)
>> +		return err;
> 
> Doesn't this error path leak the cgroup? Maybe this would be cleaner:
> 
> bpf_cgroup_storage_lock();
> err = cgroup_storage_delete(cgroup, map);
> bpf_cgroup_storage_unlock();
> cgroup_put(cgroup);
> 
> return err;

Thanks for spotting this. Yes, 'return err' here will cause a cgrup 
reference leaking.

> 
>> +
>> +	cgroup_put(cgroup);
>> +	return 0;
>> +}
>> +
> 
> [...]
> 
> Thanks,
> David
