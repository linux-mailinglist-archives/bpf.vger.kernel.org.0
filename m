Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA504BF248
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 07:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiBVG4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 01:56:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiBVG4b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 01:56:31 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C5D111DD0
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 22:56:06 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LELCUZ029334;
        Mon, 21 Feb 2022 22:56:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hNYF2i0G4mS1JV8rcBDpyg9Dpc5xk1TWQE+Nd5EONto=;
 b=RucFps2qejSlWv/X+EmrhdTthVBv3kZp3mgTXCOkJCKEZtMFW+uAwdIJmUC4P6HOG0tT
 UZceRefW1+ZDhZs+tMH75scddGvRM8+nbP7iflc4nW1n4jwiAoMgpmgr3u3B3mkIquuZ
 DZos8tc1ngetUsytEEJ0cnlKhNquZK5bspA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eccdt3xsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Feb 2022 22:56:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 22:56:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVdx81sYLyYxwoGVE/sE1+52L5H+8kgJjqdnDmbPivzT0WP4MyUSE4HQUik2FyEdUdqgOjeJdGWHxsyZbwGz6Jve7pBGFRGLEsr9uDTABKlnteQkFCYPMzw60Tgft3XcaXvSUYIUZE+k9PN1r49gYeTSJxnCNlPFYy2CMLxgWODzFQIiP2hzEdbrKdbD7l6xXO4VxxYI6fIpjVO2H/RK/q9IDSjTA+G7Jjpgd9zn1ApLBeSlm5uvQBwzMmCFRviISz8ljbIuWvB+1Q98NyF6ACOpPnwAq5hVlngF8y98Zz5nKsBJAHibRGpqSom3OLvwzeI1+9tmgAeCoIuMy3q/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNYF2i0G4mS1JV8rcBDpyg9Dpc5xk1TWQE+Nd5EONto=;
 b=f0e9N34LC6QUIsKQmUfQlFfZ/+YRomA+v6iOB1+lAkFG8wuIqzpRAZ/GzChlOVJoumF/oih+8DjL3FciwS3eMWAz8CYOpjKxhcJ8h9daD6l/asqta8zsA6sJyOzCKRblTGtMgkMj98fY+uNFXK3PKJugba0dacur3FC4AZdkXtEl7foDP8TXeGhn9U7rLyAsExGjNcZWJI23X827ITsUlA/GXwe6V6xQ2zX0FeeFropE5GPZgIcT6fomXi2nzUY73KiamqtJPw4ji/RZbJrRRBNeNYPln6QUNYam4JMt4GtXqZDirL27Tb5rK5QVbHDb3VHkxZOTnxgNArA0SeMXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2823.namprd15.prod.outlook.com (2603:10b6:a03:15a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 06:56:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 06:56:01 +0000
Message-ID: <6bbb282c-2944-5e22-0869-af1905fa6ced@fb.com>
Date:   Mon, 21 Feb 2022 22:55:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: BTF type tags not emitted properly when using macros
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>
References: <20220220071333.sltv4jrwniool2qy@apollo.legion>
 <11b93216-2592-adfa-1a0b-d8d870144f90@fb.com>
In-Reply-To: <11b93216-2592-adfa-1a0b-d8d870144f90@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:300:117::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffd9c75f-f704-4747-14df-08d9f5d062fd
X-MS-TrafficTypeDiagnostic: BYAPR15MB2823:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2823F750F97CE952BEF3E2F3D33B9@BYAPR15MB2823.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLO2k/wE3MQZ+UhJKu0gs4xF6LhEWAcOfPUS15kjOHmvTj5CrFzdOKz4x0BnX+IALjDsaVHBQcm7Ydo8x7jX6cl+xyph6wDGvS+wDNl4NH/5XsENh0eEo7abkVWjSHyrYGfV8dpRtmLguqS0BwBWI6MC96V0BuQwTjYpnyJOAhft9peE4lAOkp40gzQfJd0zuDtTJjnhuVXbieA73IoRQtAeH+1MkN3PZhJ08isQy8pKGhmNb0vIYK7bL2+t+JuGPg2/HSb2zjevZqGfWDqRjhBnbGv01ICplanXIsUN01aRkbteWSCLUxCxLO1S2ism3zqrPG4wXcIZdU3R8COuk3zDyudZTf2fWvcWOE2uvr+iB3Z7comSm17GJ/8m2QtdKvbcsYeXoveiu/yisaHpUbF1QUl2/EEXLceQqzBbJg7jr/XyVVFERpsVT+dEjJ7zq/YF5TvD4FG+vFLf3xnzpo/H51dT4NtJKIc4cs6oX7PTN0+Uq6LGeepJ4IM2bYVjMFWu6ULi3a34Q2QBY+V9XIE83Bisd3l3wpu84+Mypo70w+xRrb0idjVfic73BXrbYLqWqg3bOMWSVNAHcIJZHXlGaICposkPNnUbI4aF6UPnGH+t214P7TB6Og8B9b9mJehOZ3JuISfnKk5eCWSlVXKNJ8QwpWTz4m4c6os1raptq5yYLcFPZIqeQd70CLXKIwNonKoMqIF0VuRVkz+Z5DA+fe1ciLXW29lJK/32SDxp7P1cLThI2hlKdgQ6e/sUEwHsChDP2Y1V/N3Hl8+u93K9/rwFFBvwxeyQVipmgrxnXv4hoUdfTJarcl9puiRT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6512007)(6666004)(66476007)(66946007)(66556008)(186003)(508600001)(2616005)(83380400001)(36756003)(31686004)(966005)(8676002)(5660300002)(8936002)(316002)(6506007)(38100700002)(2906002)(52116002)(53546011)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R04zRy9BM2ZUYS9IbThHUGdMaWFvTGZEaGZaNWZrMURPeUU5YjVFaFI2RDJV?=
 =?utf-8?B?OUY4S1lIWU1ldk5MMGpWSC9odXh0elBmbmtmblZBUXE4UjJGZGg0UGJtUTZl?=
 =?utf-8?B?bWRvb25aTVRKWFZXZjgraUdpOTk5L1dOdGMxRHFySzkrQTJxWjhRN2ZsMlFZ?=
 =?utf-8?B?VjN2TVFkaXJHemNZTUV4NnV6NndQL2dGUkkrTkxqdFhrYU1jVlFYYjBnMDho?=
 =?utf-8?B?Y3BGbDFNUjJJR2pJcmZMTk82UzA5NGFPN0R0SjBLdDNzQ3JWaThDVys0OEpo?=
 =?utf-8?B?ekg5RUhPODYvZmxuUEtSaFd1dUtKbnBCQ01xanFhSzdJZlJpVnJoNHZtNkdt?=
 =?utf-8?B?SXNKSHZxcTYrMXd4R2U4eXAzc3VGUnNhK0RLVXE0M2RqVDNuN000RGNOeWl5?=
 =?utf-8?B?c080RkZnQXhya1JYbDVjN1IyS3BnNUlIQVE2Y05TNjl2bjZBOVdFUDFJajB0?=
 =?utf-8?B?TjBmdWl0WHY1Y2hYdFM0aEtPOGJyeUpZS0VmS2ZaeHpaZ0ZlZnBYN2lIbmQ3?=
 =?utf-8?B?TjQwbzNMR2lDemxZbmlYSndqUFhibzFWbG81Zkg4RXIvZEVlSjV5OERkWFla?=
 =?utf-8?B?RFBSZG5STzdWbFpJTEFHNW5waGdLaEV5NmhaakFqRkRZOXVsNGt5bGdjbis3?=
 =?utf-8?B?TkVWR1hwUzZnL3ZnZndJdCtjNVBBdVpCYTg1c2wxWVFqL0s0SzRHbDVuNHZa?=
 =?utf-8?B?YzhJL25Gdnp5UjlCUEkwZXg4QlpsNXBDeC96b3duY0YxcDNJT3lmUm5rWWhQ?=
 =?utf-8?B?UFk0NmdpU3lodWFWUUdJL1RvUGZFVStBSjZnVFRyVFRjRTlFR2RvY0gzZk5G?=
 =?utf-8?B?QXdiT0pYL0dSczlZcUttYlB6eGlkSkQ4MGIyQXdxMlVvazZSalY0cnR1UmZ6?=
 =?utf-8?B?cFROTklEVVpzRmUrYWtKMkZPZlNnNTh5SWFHaWdyeEpSZncwOGZENTh0THlQ?=
 =?utf-8?B?aDZBQW9aYnphSE9KcElFeVUzcnRsTUxSYTNzY1Vxc2VHZnJ5Ynk1Y29RYmNk?=
 =?utf-8?B?bW0xbjRQRXpOcEVNYjdFd0hER1lhWFp5Y21vajJjcSt1SWtZc0VpMU1YZ2dM?=
 =?utf-8?B?SGUzdGlJUFFpa3pUNkxaL2FnVmIvQ1FDa3FsVXV3cU1vcWRHRlZEYlVHTnJM?=
 =?utf-8?B?Mi83Ui9TaW9DQ0FFcHdXMkhHN0lDSUVjSC84L2xQdWk3QndFNWtFUnBzSFA1?=
 =?utf-8?B?MnhtOWU4bGI2RDcxMm13YkNXUzJNektoNDNmcEJoKzJ0VUp3c3gwVjFDZkhl?=
 =?utf-8?B?N1dSUWc4Qkwxb2pZRVNpUE9sWFFEL3I2eGpFZlFRQkRkcVhGdyt6NUxlNGZB?=
 =?utf-8?B?TEpEOGNFZEY1NU9VYjloLzhjTUNGK2JOZFpOZVNTT3QzUXcvaEtWQ3B5cU9q?=
 =?utf-8?B?OFZsU3F2MzI5cXN0OEJWczhMTHlFZStjQ3NwYmcvVVc1eHNtOVZRNXhIcWRo?=
 =?utf-8?B?dDFMazFZY2Z1dkwvY2JMRU04ZjExVFpTUEEzbDVWTHR3WjVhUTQrVlNYSzhz?=
 =?utf-8?B?ZnlFQ3dBaDF6OEtVOHlCSFExRWZtK2h1SlFPY3I2anB4ZFk1alFtL1ZIdVVj?=
 =?utf-8?B?OWZCRUtHRkdDRm94ejhjY1gramNReWhwNEpCM1NFS3lqbTJQRzY1ek1KL3Qv?=
 =?utf-8?B?OWJZQjRpNGVJY2JuVE5FajA5dzdQNHNEWFhuMi9QQUorZ2tiTVA0UGdERVNO?=
 =?utf-8?B?SlVocGsvbFBjNE91TllhYmZzblhlc1orUTB5bGZiWit3WGE5bGlWUkducTdy?=
 =?utf-8?B?V29EU2lBVUc5OEEwQ3o2cjhHWFd3LzF3bVlLeXhjeUhEY0E2UGc1bnIrdDlV?=
 =?utf-8?B?L3RtQ1NlTmN1YkdOaWg3T0ZzcmQvWnVveUhLTjgxOUxFVXVXcDMyVlUzRWgx?=
 =?utf-8?B?NldCa3dnQWN2cVFaVitLYUxOVTg5L1FxbFRsSGtIL0xnR1ltYWx4N0ZGL2NN?=
 =?utf-8?B?eUxxZXZhbjE1d0RuZzRySlJCYWpFVVAzdmNoRXR4MGlteEFNcDJEa0dQQjkw?=
 =?utf-8?B?Sk5zNXNMK0VQTU9tNTBnTE9WQm54Y0o5K1cyc3c1UnRuUlZiRTM4a1czYXlL?=
 =?utf-8?B?bnZxanlDbmU4bzl1aTlFaFh2REpHU3lCd05meVBrTVRrYXlwRGgxMmtiNndP?=
 =?utf-8?B?L3B3a1Y4OGR4Rml3WmtYTW9Pa0ZNWjhPOCtnUW1KUzNEOVUzS0NTZmV5dVQ1?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd9c75f-f704-4747-14df-08d9f5d062fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:56:01.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1udCWLPBPPR5gKIXlYrA40mBQQpYsLQtk033eFHtf95aaLf14wI10I8spfncEr+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2823
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: NnT9-te3s4yQZPekVRLJhm0zrx26SxG3
X-Proofpoint-ORIG-GUID: NnT9-te3s4yQZPekVRLJhm0zrx26SxG3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_02,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220040
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/20/22 11:22 AM, Yonghong Song wrote:
> 
> 
> On 2/19/22 11:13 PM, Kumar Kartikeya Dwivedi wrote:
>> Hi list,
>>
>> I noticed another problem in LLVM HEAD wrt BTF type tags.
>>
>> When I have a file like bad.c:
>>
>>   ; cat bad.c
>> #define __kptr __attribute__((btf_type_tag("btf_id")))
>> #define __kptr_ref __kptr __attribute__((btf_type_tag("ref")))
>> #define __kptr_percpu __kptr __attribute__((btf_type_tag("percpu")))
>> #define __kptr_user __kptr __attribute__((btf_type_tag("user")))
>>
>> struct map_value {
>>          int __kptr *a;
>>          int __kptr_ref *b;
>>          int __kptr_percpu *c;
>>          int __kptr_user *d;
>> };
>>
>> struct map_value *func(void);
>>
>> int main(void)
>> {
>>          struct map_value *p = func();
>>          return *p->a + *p->b + *p->c + *p->d;
>> }
>>
>> All tags are not emitted to BTF (neither are they there in 
>> llvm-dwarfdump output):
>>
>>   ; ./src/linux/kptr-map/tools/bpf/bpftool/bpftool btf dump file bad.o 
>> format raw
>> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
>> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> [3] FUNC 'main' type_id=1 linkage=global
>> [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=0
>> [5] PTR '(anon)' type_id=6
>> [6] STRUCT 'map_value' size=32 vlen=4
>>          'a' type_id=8 bits_offset=0
>>          'b' type_id=11 bits_offset=64
>>          'c' type_id=11 bits_offset=128
>>          'd' type_id=11 bits_offset=192
>> [7] TYPE_TAG 'btf_id' type_id=2
>> [8] PTR '(anon)' type_id=7
>> [9] TYPE_TAG 'btf_id' type_id=2
>> [10] TYPE_TAG 'ref' type_id=9
>> [11] PTR '(anon)' type_id=10
>> [12] FUNC 'func' type_id=4 linkage=extern
>>
>> Notice that only btf_id (__kptr) and btf_id + ref (__kptr_ref) are 
>> emitted
>> properly, and then rest of members use type_id=11, instead of emitting 
>> more type
>> tags.
> 
> Thanks for reporting. I think clang frontend may have bugs in handling 
> nested macros. Will debug this.

I just submitted a clang patch to fix this issue.
See https://reviews.llvm.org/D120296

It should fix your above test case like
   struct map_value {
           int __kptr *a;
           int __kptr_ref *b;
           int __kptr_percpu *c;
           int __kptr_user *d;
   };
or
   struct map_value {
           int __attribute__((btf_type_tag("btf_id"))) *a;
           int __attribute__((btf_type_tag("btf_id"))) 
__attribute__((btf_type_tag("ref"))) *b;
           ...
   }
etc.

It should work with the pure or mix of macro-defined-attribute and/or
raw-attribute. Please give a try. Thanks!

> 
>>
>> When I use a mix of macro and direct attributes, or just attributes, 
>> it does work:
>>
>> ; cat good.c
>> #define __kptr __attribute__((btf_type_tag("btf_id")))
>>
>> struct map_value {
>>          int __kptr *a;
>>          int __kptr __attribute__((btf_type_tag("ref"))) *b;
>>          int __kptr __attribute__((btf_type_tag("percpu"))) *c;
>>          int __kptr __attribute__((btf_type_tag("user"))) *d;
>> };
>>
[...]
