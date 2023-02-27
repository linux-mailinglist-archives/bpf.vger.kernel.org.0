Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D76A4FC8
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 00:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjB0Xon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 18:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0Xom (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:44:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3621945
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:44:34 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RLDLU0002014;
        Mon, 27 Feb 2023 15:44:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=dR1JAZWtFBWrrual8eFdUGmhoyF+i1nDpyNg8NyeEwI=;
 b=T7P5uAeQYOFnfRaTwAVoY0YLL5mUaRacZe0XzbBM1KvxurzzG6xWcKRQK2H0dBOEBCUW
 hnc1SU0LkicniV8QvPfOY7zpomA7RfQQkULre7HttSq1mWBcO85siKmTD7Xgovn2ljbX
 GoxrPAn3PbQpzFdr4jY3xOuTeKzrawGlmdLf+KkPjWHcXEomeTz8inpzZ5N/gNDwOb2F
 oEKkOKCiGudnfIOppfzQnnf57Amihu7vtUrxMDvjW3jH7AaMud8NandUfIYVOGkX9QZ5
 bnChiIHi2XlPMW9k6OhBd8r4DSmkSuJIgJNDBO3CWOClnCh3+4OufilqjwfSkR0fYXx1 Tg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nyf8s54b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 15:44:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUIMUQa/7VFkVtXqrXvCLEM0F3ReI7s33ch832RYVKSO5A+zqKUXMXFBPa+7mNaTG5oKnhnAQXxwHyo3sMAJk7XYmOY2OcjUcrbwVj7T1rFFVOFUriMLNy6xwxkwifUdlWR6NfcPrIfGZpgvaYmatPkfW1Sz2u3QW5wPKJRhJVaAs7Wf78ArhjGJe8fmOqe7SjoXH7EoZ0s46yXo+EWWYSAJU/sbXYhujerPQ0GE8m55Smm1pQj5gN0Sxk9hFkg1iu8gLMXMexc0U/PU4JOhHHcvjOGHdhZKAzoHWDL2asDZ+72uUsoc/TvDMkbXcPDU1tgHWdYe8YSHJOHoC+6EdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR1JAZWtFBWrrual8eFdUGmhoyF+i1nDpyNg8NyeEwI=;
 b=kBfJgkS3TxXtqCpOgzF5RF9m/B8LIU9U6augag3bWdKZ903Sq3H2NyftMqj0ghGy7cqf4mRiStS7bpHXdpqIBbf+PbECtQDv6EV6t4Dmn7GFGZRLNSOB1HDDdMicKYglrZhfJMVVA8spwITts4/jRFofVFzd96qY0dBjHViyBt1slKu9kn0FQceZ8XIVmFGs2M0WLALVgQN2ciPSiJisZYhnfAElWCB19pDFA2+kgetfJ+RUL0Ul3k2ZtShhGppl9zM0C0A+rJTfxHBzZX/Zzvhr4taidMwLwB4++Os/Rj4E5G2MAaMJX/6rZPv4ZCeto6xeaa2pBkRhPnm8apK4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3870.namprd15.prod.outlook.com (2603:10b6:806:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Mon, 27 Feb
 2023 23:44:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 23:44:17 +0000
Message-ID: <d32044c9-e1f9-f33a-21fc-d595ac349cc5@meta.com>
Date:   Mon, 27 Feb 2023 15:44:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH bpf] libbpf: Fix bpf_xdp_query() in old kernels
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <20230227224943.1153459-1-yhs@fb.com>
 <CAEf4Bzaqqzxo7fMNxrYXf5VgLVqSR3cOGkM6KF=hTNqcc1DTBw@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4Bzaqqzxo7fMNxrYXf5VgLVqSR3cOGkM6KF=hTNqcc1DTBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3870:EE_
X-MS-Office365-Filtering-Correlation-Id: 068afd9f-5ded-45af-5445-08db191c8a1f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tssRM7tQzjr8nAPCxAmsNlAbvfNMKOhupN3PM/R4L9Z/6tEdobwPumq0l9RzP0oKwbooan3mKzQ0nmrbXXwL4zZByBZTWD+kq7XkOxQV5vWAbzmpmxEJUKlWhfPpokuC9l0RMpVx2byqg2mzGegiLI6C9t/3g9exQt5Le95Z7ya1kwvkdyqYS0Yb7uh2x8QGVhI6g1cuYRd3Ig/snp9WeMRk6m3e8e3+xeNTKbkd4fFHpahWO9QN6Cd36qTN3uqVIH9seT596Lxy6gXPCh3FaLosKvo6K6qkFmvieGTKHp4N3lhuj+CBk5PAEP/gm9sIGW94iff36QtEVx5K2XgawitEWePouSyozrgsEkuTAfnM/H1aOwdtaCNrJmTCb9HEd9t6L//nM5VYBDUTvPrwWKM32npG8Se2nmtk+4FLlLAMmxizhqQ348VTFVNhvmH8959MZRQNNJiSebamI2pUfLMI//K/tbhfLjADONAeIuY2ylCSNhsP+jezRy0I+hNdcUEcn+ynAnllGVSc3TBreq/ztEyD6FmetWzsreVrjqT+Rz7HBnwWlC7sO7E/w7LZsccfny9HvM7oJD3RsUuzIv/9cpuZ7isidUTGiP25+RfxZ+lwz2tJi/HnXIuMIOhwZ5lUlCwPIh3mqBEyVwKrkT/bzzRf+m49AFj7u5ujMvTtVY4zVBm4GchbIm/xNYdl7dOylPow/Ggv0m25oCkbYf70XAONIFjFN/2amiMwfD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(451199018)(38100700002)(86362001)(31696002)(36756003)(2906002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(2616005)(53546011)(6512007)(6506007)(186003)(83380400001)(110136005)(54906003)(478600001)(316002)(6666004)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXIvdWhBZ3RMbFhqUXcxVExIZkRRUUx5ZVlpMzBQcWJhNUdoYThmYkhDZHdy?=
 =?utf-8?B?REM1bzZMamF1ZGNZL0hsMW5RRVk0YW9qUmlGeE1PN1IvZ091ZXh3b1BybHN1?=
 =?utf-8?B?d3hsWnFtZEsrR0hWREdtRVllRFZwNTBZV3lWcFlGaWZySTc1b2o3bmxQMG83?=
 =?utf-8?B?UlFjS1d1T01Ha1FPeWtRdzZ1bkQwOWFwcmY5SU5JMVJ2K21CRE0xRjAvSXpY?=
 =?utf-8?B?L0JsZjBvUDByUlozZlNodGpzS1lFdWF0cEdkcmdaL1c3K3dtSmhGQ2pNS0Ex?=
 =?utf-8?B?TThqNldEZjVxSmdCeXp1SkxtRXRES1hLaDRGaGZXcThsTitJTlRLd2JHQmxP?=
 =?utf-8?B?NDB2ZVZXSytoQVhPZXVnb2dWM3YvZEhGL0p4cjFnTE9kQUVQbjBsTU13YW45?=
 =?utf-8?B?TmJzWEcxUXp6cmhsa3daSlFqQm5WNlpXZWtsSmNKQWtoeU5pWVpVWXRRWHkw?=
 =?utf-8?B?eFlHS0J4UWVCQ3ljeW54Rm9IQXRCbjlpY0R2N2RhSml0dSsyS01jQVpiSUpS?=
 =?utf-8?B?TTBzT0IyMFp2cFZJM1R4MnY5cUZBdjFhc2tDWlB4SWtaYmJsVXFKSjByamNG?=
 =?utf-8?B?SG5WcWphY1lhSndjT0lJRkVVNzdva05iSm8xaFp4TlppeityWW53M3pLaW5D?=
 =?utf-8?B?SDFFUGxkWUFNNkNkRXU1eG9mbVZ4dm5TWTA4aHZrSVVOUnNwUlJJY0ZIdDg0?=
 =?utf-8?B?QStOZFBmeUhEYTUzVVlwZzhFTGgxZ1l3RFV1c011K3l1U3hPdzFUWVorUW9a?=
 =?utf-8?B?NEdMeW55K0hka2tYamlFTmExNUlnQWM4eG94SzhzazJMbGh1VzA1d2EvZUlT?=
 =?utf-8?B?UmdtQWVIV21SeGVjd204S1hMblNBdC9jNjQ1YkVIamlncVVkN3FpVERmMzlj?=
 =?utf-8?B?UUhVdVJTZDNYWjBuZGFVSTVGbCtTZE1VTVIvZ2lHTkgwbGxRc1I5M29wbmF2?=
 =?utf-8?B?UjUyelJLOWN4c3VqSXRqaHlzM2JYYlJjL1ptb0ozRjl6OEZIUEUzL2NFdVFn?=
 =?utf-8?B?RXY1N3RZQnlKTzd4K2N4dHVJWDlmcUkvcmtuejc3Ujh4QmFCcURRREtxU1pa?=
 =?utf-8?B?WThFQWlSWHhJbk1CYUZ3bnk2RFo2K2REdFdNY2pSaDdrQjFlaU9TN3VycEJ4?=
 =?utf-8?B?M1doVUVyUGh6MXFPOUJ0Rk85SlNJOHF6VTk2NDNPVys0bmN5RVhWS0JlTlB0?=
 =?utf-8?B?dVQ4aGNFdFJSVWhWbmlTVXZlZ3dZNzVNaW9YaWk1QWY4MHJtRngzM0xaNjNx?=
 =?utf-8?B?eFBuTG41cWhXd1JISFJiOUsrZGlJaW9WU2pjUjlKYXRsMXpvaUVDRWduenhY?=
 =?utf-8?B?TE9pQ0FlSDM5TzVYcHEvUkVZbTNzWmNLZmhuUXNuYkRuc2pkSmVnZHNtbjBO?=
 =?utf-8?B?UUE3Qnl3MkVyS0YrMEt4VUFDb0VHUzQ1UmlpaTliOXVMdXYzUzhCWVhhVklS?=
 =?utf-8?B?UGttaThMOTUyWkdPbmdRN3VyVkRIcGpSaW9Kc1U3VmthQndzN0NqRWg5ZG0x?=
 =?utf-8?B?b2RUZDF1eGJqOVhPVUxNWGRrSHl0RXRJeFdvRWJsM1ZaUmsrcFpZb0toWElv?=
 =?utf-8?B?RWhBUTNWdE1MWWV2bDZtRWpNUXFvNkRXU2NHQTVoaDE3SW5xNkozOU9zNlZu?=
 =?utf-8?B?UE1EVlBUQm5vL3pFdHpPLzd5WGNYMDMyTTdqdDF5UWFrSTRQcEF4SzJHaTRR?=
 =?utf-8?B?cnFkdDhRbU0xOVJDQnNxTklGQTluamZ2V0poT0V6U2VwYXovVEdnREdramNk?=
 =?utf-8?B?YlJCeWNlY0ZMaWxpWDNVQkNYd1p2RWpUMXB4biszQTZ0aTNhdGRYd05BME4y?=
 =?utf-8?B?TklZNjFwRGZ2WWlZS2hDTkptVTlVNmJCZERDKzRDY2pIRXA2T1hUbDV2TkVq?=
 =?utf-8?B?NFByWGZ4TnZianZ3RG0rOWphT1hySDFUdzF4TXZqR1hJbVdLOEpURWd6eXBj?=
 =?utf-8?B?akVNVmNCVmp0VnQ2Nk9uV0Q2UkRjVStQTjhaLzZDRlRvM2RidWh2cFVSVWk4?=
 =?utf-8?B?d0dyekgzRkhkVS9mbFBRbm5iNS9Da0MxMllDYWMrZXJxWSt4UUlCTVNxemxZ?=
 =?utf-8?B?ZmJmVGcxalI1alNHZW1lbURWSGREVHNIVVRhd2NSZk1IZS96b3FMcXB5TEYz?=
 =?utf-8?B?SUVzbUxLN2JPemo5c3YxUTcwVFp6cndzTEZValNaNHBTdlZCOWd1dk5OWG5U?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068afd9f-5ded-45af-5445-08db191c8a1f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 23:44:17.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ByAxfzZZI6BJ8Vu/xwC35calYLblJlW2J4zw1E+0MRv4AYK7SApF2QxrarjPOIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3870
X-Proofpoint-GUID: bccoYpUIEvhh9xXu7NY8VrNFfpS3pRfX
X-Proofpoint-ORIG-GUID: bccoYpUIEvhh9xXu7NY8VrNFfpS3pRfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/27/23 3:35 PM, Andrii Nakryiko wrote:
> On Mon, Feb 27, 2023 at 2:50 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Commit 04d58f1b26a4("libbpf: add API to get XDP/XSK supported features")
>> added feature_flags to struct bpf_xdp_query_opts. If a user uses
>> bpf_xdp_query_opts with feature_flags member, the bpf_xdp_query()
>> will check whether 'netdev' family exists or not in the kernel.
>> If it does not exist, the bpf_xdp_query() will return -ENOENT.
>>
>> But 'netdev' family does not exist in old kernels as it is
>> introduced in the same patch set as Commit 04d58f1b26a4.
>> So old kernel with newer libbpf won't work properly with
>> bpf_xdp_query() api call.
>>
>> To fix this issue, if the return value of
>> libbpf_netlink_resolve_genl_family_id() is -ENOENT, bpf_xdp_query()
>> will just return 0, skipping the rest of xdp feature query.
>> This preserves backward compatibility.
>>
>> Fixes: 04d58f1b26a4 ("libbpf: add API to get XDP/XSK supported features")
>> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/netlink.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
>> index 1653e7a8b0a1..4c1b3502f88d 100644
>> --- a/tools/lib/bpf/netlink.c
>> +++ b/tools/lib/bpf/netlink.c
>> @@ -468,8 +468,11 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
>>                  return 0;
>>
>>          err = libbpf_netlink_resolve_genl_family_id("netdev", sizeof("netdev"), &id);
>> -       if (err < 0)
>> +       if (err < 0) {
>> +               if (err == -ENOENT)
>> +                       return 0;
>>                  return libbpf_err(err);
>> +       }
>>
> 
> As I mentioned in another thread, I'm a bit worried of this early
> return, because query_opts might be extended and then we'll forget
> about this early return. So I did these changes and pushed to
> bpf-next:
> 
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 4c1b3502f88d..84dd5fa14905 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -469,8 +469,10 @@ int bpf_xdp_query(int ifindex, int xdp_flags,
> struct bpf_xdp_query_opts *opts)
> 
>          err = libbpf_netlink_resolve_genl_family_id("netdev",
> sizeof("netdev"), &id);
>          if (err < 0) {
> -               if (err == -ENOENT)
> -                       return 0;
> +               if (err == -ENOENT) {
> +                       opts->feature_flags = 0;
> +                       goto skip_feature_flags;
> +               }
>                  return libbpf_err(err);
>          }
> 
> @@ -492,6 +494,7 @@ int bpf_xdp_query(int ifindex, int xdp_flags,
> struct bpf_xdp_query_opts *opts)
> 
>          opts->feature_flags = md.flags;
> 
> +skip_feature_flags:
>          return 0;
>   }

Sounds good to me. Thanks!

> 
>>          memset(&req, 0, sizeof(req));
>>          req.nh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
>> --
>> 2.30.2
>>
