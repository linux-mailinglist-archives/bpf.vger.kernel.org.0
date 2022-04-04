Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778B64F0DA9
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 05:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376978AbiDDDOx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 23:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbiDDDOw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 23:14:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8378A2CE21
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 20:12:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2341T3WR007500;
        Sun, 3 Apr 2022 20:12:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=z9TQRTxc4vREG25N3DzMKWqB+uPOi4Z2LmC1qrKj6zU=;
 b=ZAwvj5Y//82O8yi/YZCQjQK/A695eGjDmJZ0+rHqlHWx9L5k5bk4AdTOMzt9JJK8V98z
 wR2aNf4ZH+TYqFJ5TJEH2DjlBnfbJ7OErVihV8NoGWevFIx6MMJfThj1fHe3P9XV98B2
 VAepXv3xlsSRQuP00jAh2Thv61WyqGln6D8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6m0wf4yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Apr 2022 20:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHm25rPlOWRm/f2PRAbnmKXnlxE7Coiu+NNdo4Mtdi/UoHdXyANvn+3CTatiJ4VW6vZesaBPeB2EBgDkitc086zm2VAoGec6tG91N56AiQ0y5RpSIN1uKR8KUQO3owTnCPa8Nvc5M1ddf+D9ro0/CXL58u87NQUwgb3SmsguoNnJVIN1VncXeXJMeM+ObhTR5sanxFce5qamnliU0FbyqyLhdSk/82TMbwgxOlR7mlo1J8Z77eyzLqaCIOTTDIUBFGMPuY3AUhjbhBD6vVRySbgdoqSGq3Ngxi17dRkZwb97ZYhTcP0V3wS74SopUIW0dD+AdEsG3M4ygULwhtAtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9TQRTxc4vREG25N3DzMKWqB+uPOi4Z2LmC1qrKj6zU=;
 b=dBvqwNSE+K5ZVW5x4zofI/MU9fhpTAY1Rf/fAaFel6XrQ51wL3Da+d6H/vKtO7AZY9vi73Nt0154q32jPkQenNC6aPwCtyAImlVj8ElSQiWK5k3iT71F8fChELB78mPOl7AaW47+WGe/Bbmdg/3xu0p5EkjaGWkqyvftmLPECoE17BMGIZ4nqKmjzM4OawCqQmCIaA1tnCPrMLqEEAM9nrN+KR9Fn5qqO8JLK5jEiMiBWND8RCh8RoW+KliVEvbQK71ULQIxssGCHLGEznYrADr2h/DzkDzy2bCUmXWJ9QS/pA9Ps+AjNDht4l2PWkRXCEa/xy9T4JPAG2hxXMZjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR1501MB1991.namprd15.prod.outlook.com (2603:10b6:4:a5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 03:12:32 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 03:12:32 +0000
Message-ID: <22359fb1-33a2-ee2c-4300-a07b175825e6@fb.com>
Date:   Sun, 3 Apr 2022 23:12:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: wire up USDT API and bpf_link
 integration
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220402002944.382019-1-andrii@kernel.org>
 <20220402002944.382019-3-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220402002944.382019-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::20) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3050e2a-610f-47a8-45ba-08da15e8f5d5
X-MS-TrafficTypeDiagnostic: DM5PR1501MB1991:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1501MB19918588CDD96E33FE40E8DFA0E59@DM5PR1501MB1991.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmlXeDVdX4njYS7Tv9iyjtfXfRHa9BRxaH6yBDRrtP7FKHuISGfXHmUww2Qjz4+ztcnhS/hwkselE3FAcfiakjhbRx6NGIubXp9iFUD3kFs9R6lT0CLug1rizyrPgWxg2fi19Z536XCD0vH1JWd/cXDAaQf7iSzfT7hfjAjC29cayxw6e92vtMgn1SHNXKQLvt9UxoOgxram7wUrGp3pcGw3Uo5EUD8k+PVR3EdfUuXoT/GdgAbhhgwpwA7F020fPwqeXWSFIXBl0CTX95WwZvnFhI/6e15usL3PXVOYbuWrxk3mCyv9J72h61n+VJR8RICx4/YENoqZinH5t4G3Kwu4PX9D98T0Z/SChTM+FwniGwiduuP+fH9bmf4ba6rekaB4HqaLTCEoVJ0agD3nFSaCEMO2WH8ONUn6/oXCy/es8dU9Jjvjz87EQD8rEJU3a1AKJ9HFmGzWRXkfyRAyyQjiI7/rN033RCipTVe73dvPKcRGUnwrszcOxEv5MS70oFMJG0bmjR6VKdfmupRgNDUhqB9ZRh9BJdAV3TBH7OOsSmROY/PzXZgA2YFBym4iKRqgoObD5yaM5UeSCRkU0YQtvP2kYRC1i30FnKvuPA3jLMXK/lAJYX8XcuyXscCPkZYxINHB+mf+a9dlffiL3jGTzmBmcGuudmf+TyBjLXJerAXEsnFJjETTR5AOOxIQJEgGjaw4M6JOCcmGOC1LVDpC+90HguanT+Bf8Z5YHA6YEI18ssaa5x0f+Pj6Lx84CUxa/hDUHev72VwptEPjSq3cxWr+xmcjhOvzPzr2SSP1hED+HvxmNz0UvpGW6X/jsILu6UUiLgIGeJJcYaJQN8pAp5WO9VBTqGIoQz3IvZZJgV5sWKGHuCJdp7ojOOlL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(2906002)(6506007)(53546011)(6512007)(38100700002)(186003)(83380400001)(54906003)(5660300002)(6486002)(36756003)(508600001)(31686004)(966005)(30864003)(316002)(8936002)(66556008)(4326008)(66946007)(86362001)(31696002)(66476007)(8676002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEUzNUpPbm9YUzlJU1crVkFyQXc0Y0RORlAwNlMrUlNKTGJaK09OYXNram5R?=
 =?utf-8?B?VUpUdHRETFdNcVZieFA2aUpuV2Rsb1k5ZlpUSHpUd2lDRC9jeEpIYWZPZVpX?=
 =?utf-8?B?Z0VzcHAxeDIrNlVpZWRRWDB4UXk5SzRrazJCWXRpRS9Zam8xZmQ1WThmYnMy?=
 =?utf-8?B?bTdqYkVGZHNoenR6dGd6MTlsck5RUU43VVJWZXJyd0JoUDFmeXhkTm5zV09L?=
 =?utf-8?B?aUV4ZFlaZGZlK1Vhc0pTNmtxNmt0NTVjV2ZLbDhhdlJEdTQ4QTl2YVZUbnFM?=
 =?utf-8?B?K01qaW1PazNvUmJFOUdxeUFUWWRWbjduSXYybDI2SjZZWFV5R3NaRk5lck54?=
 =?utf-8?B?RXV2eDVreG5zQ2ZTb2E1a1NXN1JOSHV2MU9QVWpUVXVUbDNRaWpFMjlaMUtI?=
 =?utf-8?B?ZFErRm1lejM4NFJkY1FKeUk5NUdkWTFHQXpvczVNbWtHcVpTbDBaRDZZVTVP?=
 =?utf-8?B?aUZTYWdBZEhUSkFPQ1pYdVNrcDdOdGZGeDQ4SkNtaTBtUy9BUkdHaEFLdVBv?=
 =?utf-8?B?bGtMR1lzRDJGL040UDJvZlFOZmJhUmNESFFHZnZubmJMVFpDRVNrNzRYU3pp?=
 =?utf-8?B?SnpwVXA3OUFWL2V4Slp5TGw3Q1U0cnM4dnQvSDdLOVJSOVhFdVZsSWdkS1Vk?=
 =?utf-8?B?WnJyc0VvMmVoL3dKemh6L3N1RlFjVHZCWWFQTmIzSzZ4M3dxazhFTmZYb0FJ?=
 =?utf-8?B?YVhLL3VheVJmQ1ZMbUVhOEZvMS9Od3VON1lLazM1TVVVdmtLZTBCY3VOQUhN?=
 =?utf-8?B?bTl2U1RnbnNxeTJTV2c0bnB5MHpFRFdMUnJ2QlcvT0QvT0cxT2k0ODZFaXlI?=
 =?utf-8?B?OVVvdzRwMHgyY0gwYnVXQXNLWUJhZDNOL0J3cVMxanlUakVWVnZjL0pBcWpq?=
 =?utf-8?B?TUtVQ2pGckZOS0F1WlhDZlk2VDQzWVpWbC9DWmdERFZoMjVSUy9uY1doUW5u?=
 =?utf-8?B?c1ZQdksrYXp4WG5RTFNPVEgrNmNIOFJNTlZRZnRZS2RaQlVUVkhFajYwRFh0?=
 =?utf-8?B?dVhaLzFMc1Vpc1h4cDJKNW1SOVhwQnU4N0xCS1BkcDZmVTJmODB6QkpoMUFH?=
 =?utf-8?B?TzlwZ25UeEdQcHEzUU55M3BXUGpNODNVSnNTTHFmQTcxR09hVW9MT2kwU0hX?=
 =?utf-8?B?dHBhVmhVdmlZcWZzUGRCRGZzVWJZR0VjY2cwNHB0SXl1MklRM3d6cW1zRlF3?=
 =?utf-8?B?T1ZkTmEyS2xRaXptdVVhdWthY3FIaHRXRk5ldmJUbXlxU3RoTndmZ3h6Snd1?=
 =?utf-8?B?RmtqYjhhUENrRXJBZGZSNEJEQXZpTHdnR2k4QnFkTndGaTBtQ3p3S09TKzdQ?=
 =?utf-8?B?c2Q1NXp6Wk5JVmdIQkk3UUU5NVZrRG56d2JCUlVRc2hsUUJCTytINzF2N2wr?=
 =?utf-8?B?MTB0VVM3T2o3OEhMTjdEa2s1c2hGdExtWjJsemVXR0NiRVVjVStiZjQwMTJq?=
 =?utf-8?B?enFDVDc3eDJWTUNzNzQvV1BuY0kzdU5yYW5FMkhQUFg2SFdCVVl5WXdhQXY1?=
 =?utf-8?B?SS9ucndqZFhCOGpqQ3ZoN3Jsa0d6ejJRUUJkWkJOMk9Md1RSWFA1bUFsZHRh?=
 =?utf-8?B?OFhRWEdla1huZVpIVDN6cjBUekNsdWYvSGlpa3RNbVI2ZHdjRy84aVVKK1JK?=
 =?utf-8?B?d3NjeVlMNHI0N0ZPYUQ1ZUlQVFkwTVh5NFZtayt0cGVsY3pzcEdkSnNMRjNJ?=
 =?utf-8?B?elpzVUFlRXkzdktONGI0c1pPVkFwNUdLMENnZEIrYWl5Z0FVR0tkaWxVRUxa?=
 =?utf-8?B?dTNhZUNueHVBREtmV1Ivbk9iTmdMR1I3U0Q5TTNEQ0Z2VXZRbUFvUk4rUmVv?=
 =?utf-8?B?WUNPalJZY3dsR255UjJOTUw5Nk1EQVNncXhwZEtJU2k0aEt1Vk82Q0hndENY?=
 =?utf-8?B?L0xKWUFXR290SDliZEFNbnhIcDFIVWRnd0xZaGkyajNmM21qOTY5WHRHOUdo?=
 =?utf-8?B?elVKMVdzWjdqckJwOU12UEdDT3FSN2V5R05LSXI3WCtONUJ6cE1SQnZUR1Yv?=
 =?utf-8?B?dkRLTU1DNUxzK01YUnQrMDRTaWsvbkpsM2J2M0x4djgyRkF1Z2hqajliZTcz?=
 =?utf-8?B?cU00N1BHaWtER2RLeGJEK2Y4aDA4STVvV2lwbTNQNjFoRHA5U1orbXhtZXpE?=
 =?utf-8?B?UTBrZnU0cTJYQ0NHR1pVV08xOGFNTndpVUUzUzRGOEFSbDRIcTlwSUt4VVJR?=
 =?utf-8?B?d0toQ1ZBR2syb1FzbHhleGIyei95UERUT0dVZ3Rvb00wQktzQUw1YjJxVm9Q?=
 =?utf-8?B?Y2hWaktiZjU3dzcyZFp3MVJ0ZXduRG42T2gwNXE5aDlMbG5ucytmZjdWMTRj?=
 =?utf-8?B?TWc4bFFWMWJKNGlkaElCLzlWY2ZCUm1rQU1YVkNpckt5VUZYdFRGVkVXcjJl?=
 =?utf-8?Q?4gQ2hpanfOhedJw4j0cnux4OsaIkDyGA+6/Y4?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3050e2a-610f-47a8-45ba-08da15e8f5d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 03:12:32.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDCFwTdUH7wHhUWz+dy0I198H/u1LeM9lP45mh0egh2Sw6EtFHrZd5h+sAHOn5oFw7GLw/tJk89zfmt9kWGKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB1991
X-Proofpoint-ORIG-GUID: lAVSrhnbv60NlIsb2CqL78T2bCeErU8T
X-Proofpoint-GUID: lAVSrhnbv60NlIsb2CqL78T2bCeErU8T
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_01,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/1/22 8:29 PM, Andrii Nakryiko wrote:   
> Wire up libbpf USDT support APIs without yet implementing all the
> nitty-gritty details of USDT discovery, spec parsing, and BPF map
> initialization.
> 
> User-visible user-space API is simple and is conceptually very similar
> to uprobe API.
> 
> bpf_program__attach_usdt() API allows to programmatically attach given
> BPF program to a USDT, specified through binary path (executable or
> shared lib), USDT provider and name. Also, just like in uprobe case, PID
> filter is specified (0 - self, -1 - any process, or specific PID).
> Optionally, USDT cookie value can be specified. Such single API
> invocation will try to discover given USDT in specified binary and will
> use (potentially many) BPF uprobes to attach this program in correct
> locations.
> 
> Just like any bpf_program__attach_xxx() APIs, bpf_link is returned that
> represents this attachment. It is a virtual BPF link that doesn't have
> direct kernel object, as it can consist of multiple underlying BPF
> uprobe links. As such, attachment is not atomic operation and there can
> be brief moment when some USDT call sites are attached while others are
> still in the process of attaching. This should be taken into
> consideration by user. But bpf_program__attach_usdt() guarantees that
> in the case of success all USDT call sites are successfully attached, or
> all the successfuly attachments will be detached as soon as some USDT
> call sites failed to be attached. So, in theory, there could be cases of
> failed bpf_program__attach_usdt() call which did trigger few USDT
> program invocations. This is unavoidable due to multi-uprobe nature of
> USDT and has to be handled by user, if it's important to create an
> illusion of atomicity.

It would be useful to be able to control the behavior in response to attach
failure in bpf_program__attach_usdt. Specifically I'd like to be able to
choose between existing "all attaches succeed or entire operation fails" and
"_any_ attach succeeds or entire operation fails". Few reasons for this:

 * Tools like BOLT were not playing nicely with USDTs for some time ([0],[1])
 * BCC's logic was changed to support more granular 'attach failure' logic ([2])
 * At FB I still see some multi-probe USDTs with incorrect-looking locations on
   some of the probes

Note that my change for 2nd bullet was to handle ".so in shortlived process"
usecase, which this lib handles by properly supporting pid = -1. But it's since
come in handy to avoid 3rd bullet's issue from causing trouble.

Production tracing tools would be less brittle if they could control this attach
failure logic.

  [0]: https://github.com/facebookincubator/BOLT/commit/ea49a61463c65775aa796a9ef7a1199f20d2a698
  [1]: https://github.com/facebookincubator/BOLT/commit/93860e02a19227be4963a68aa99ea0e09771052b
  [2]: https://github.com/iovisor/bcc/pull/2476

> USDT BPF programs themselves are marked in BPF source code as either
> SEC("usdt"), in which case they won't be auto-attached through
> skeleton's <skel>__attach() method, or it can have a full definition,
> which follows the spirit of fully-specified uprobes:
> SEC("usdt/<path>:<provider>:<name>"). In the latter case skeleton's
> attach method will attempt auto-attachment. Similarly, generic
> bpf_program__attach() will have enought information to go off of for
> parameterless attachment.
> 
> USDT BPF programs are actually uprobes, and as such for kernel they are
> marked as BPF_PROG_TYPE_KPROBE.
> 
> Another part of this patch is USDT-related feature probing:
>   - BPF cookie support detection from user-space;
>   - detection of kernel support for auto-refcounting of USDT semaphore.
> 
> The latter is optional. If kernel doesn't support such feature and USDT
> doesn't rely on USDT semaphores, no error is returned. But if libbpf
> detects that USDT requires setting semaphores and kernel doesn't support
> this, libbpf errors out with explicit pr_warn() message. Libbpf doesn't
> support poking process's memory directly to increment semaphore value,
> like BCC does on legacy kernels, due to inherent raciness and danger of
> such process memory manipulation. Libbpf let's kernel take care of this
> properly or gives up.
> 
> Logistically, all the extra USDT-related infrastructure of libbpf is put
> into a separate usdt.c file and abstracted behind struct usdt_manager.
> Each bpf_object has lazily-initialized usdt_manager pointer, which is
> only instantiated if USDT programs are attempted to be attached. Closing
> BPF object frees up usdt_manager resources. usdt_manager keeps track of
> USDT spec ID assignment and few other small things.
> 
> Subsequent patches will fill out remaining missing pieces of USDT
> initialization and setup logic.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/Build             |   3 +-
>  tools/lib/bpf/libbpf.c          | 100 +++++++-
>  tools/lib/bpf/libbpf.h          |  31 +++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |  19 ++
>  tools/lib/bpf/usdt.c            | 426 ++++++++++++++++++++++++++++++++
>  6 files changed, 571 insertions(+), 9 deletions(-)
>  create mode 100644 tools/lib/bpf/usdt.c

[...]

> +static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> +{
> +	char *path = NULL, *provider = NULL, *name = NULL;
> +	const char *sec_name;
> +	int n, err;
> +
> +	sec_name = bpf_program__section_name(prog);
> +	if (strcmp(sec_name, "usdt") == 0) {
> +		/* no auto-attach for just SEC("usdt") */
> +		*link = NULL;
> +		return 0;
> +	}
> +
> +	n = sscanf(sec_name, "usdt/%m[^:]:%m[^:]:%m[^:]", &path, &provider, &name);

TIL %m

> +	if (n != 3) {
> +		pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
> +			sec_name);
> +		err = -EINVAL;
> +	} else {
> +		*link = bpf_program__attach_usdt(prog, -1 /* any process */, path,
> +						 provider, name, NULL);
> +		err = libbpf_get_error(*link);
> +	}
> +	free(path);
> +	free(provider);
> +	free(name);
> +	return err;
> +}

[...]

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> new file mode 100644
> index 000000000000..9476f7a15769
> --- /dev/null
> +++ b/tools/lib/bpf/usdt.c
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include <ctype.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <libelf.h>
> +#include <gelf.h>
> +#include <unistd.h>
> +#include <linux/ptrace.h>
> +#include <linux/kernel.h>
> +
> +#include "bpf.h"
> +#include "libbpf.h"
> +#include "libbpf_common.h"
> +#include "libbpf_internal.h"
> +#include "hashmap.h"
> +
> +/* libbpf's USDT support consists of BPF-side state/code and user-space
> + * state/code working together in concert. BPF-side parts are defined in
> + * usdt.bpf.h header library. User-space state is encapsulated by struct
> + * usdt_manager and all the supporting code centered around usdt_manager.
> + *
> + * usdt.bpf.h defines two BPF maps that usdt_manager expects: USDT spec map
> + * and IP-to-spec-ID map, which is auxiliary map necessary for kernels that
> + * don't support BPF cookie (see below). These two maps are implicitly
> + * embedded into user's end BPF object file when user's code included
> + * usdt.bpf.h. This means that libbpf doesn't do anything special to create
> + * these USDT support maps. They are created by normal libbpf logic of
> + * instantiating BPF maps when opening and loading BPF object.
> + *
> + * As such, libbpf is basically unaware of the need to do anything
> + * USDT-related until the very first call to bpf_program__attach_usdt(), which
> + * can be called by user explicitly or happen automatically during skeleton
> + * attach (or, equivalently, through generic bpf_program__attach() call). At
> + * this point, libbpf will instantiate and initialize struct usdt_manager and
> + * store it in bpf_object. USDT manager is per-BPF object construct, as each
> + * independent BPF object might or might not have USDT programs, and thus all
> + * the expected USDT-related state. There is no coordination between two
> + * bpf_object in parts of USDT attachment, they are oblivious of each other's
> + * existence and libbpf is just oblivious, dealing with bpf_object-specific
> + * USDT state.
> + *
> + * Quick crash course on USDTs.
> + *
> + * From user-space application's point of view, USDT is essentially just
> + * a slightly special function call that normally has zero overhead, unless it

Maybe better to claim 'low overhead' instead of 'zero' here and elsewhere?
Or elaborate about the overhead more explicitly. Agreed that it's so low as to
effectively be zero in most cases, but someone somewhere is going to put the nop
in a 4096-bytes-of-instr tight loop, see changed iTLB behavior, and get
frustrated.

A contrived scenario to be sure, but no other USDT documentation I can find
claims zero overhead, rather 'low', guessing for a good reason.


> + * is being traced by some external entity (e.g, BPF-based tool). Here's how
> + * a typical application can trigger USDT probe:
> + *
> + * #include <sys/sdt.h>  // provided by systemtap-sdt-devel package
> + * // folly also provide similar functionality in folly/tracing/StaticTracepoint.h
> + *
> + * STAP_PROBE3(my_usdt_provider, my_usdt_probe_name, 123, x, &y);
> + *
> + * USDT is identified by it's <provider-name>:<probe-name> pair of names. Each
> + * individual USDT has a fixed number of arguments (3 in the above example)
> + * and specifies values of each argument as if it was a function call.
> + *
> + * USDT call is actually not a function call, but is instead replaced by
> + * a single NOP instruction (thus zero overhead, effectively). But in addition

This zero overhead claim bothers me less since NOP is directly mentioned.

> + * to that, those USDT macros generate special SHT_NOTE ELF records in
> + * .note.stapsdt ELF section. Here's an example USDT definition as emitted by
> + * `readelf -n <binary>`:

[...]

> + * Arguments is the most interesting part. This USDT specification string is
> + * providing information about all the USDT arguments and their locations. The
> + * part before @ sign defined byte size of the argument (1, 2, 4, or 8) and
> + * whether the argument is singed or unsigned (negative size means signed).
> + * The part after @ sign is assembly-like definition of argument location.
> + * Technically, assembler can provide some pretty advanced definitions, but

Perhaps it would be more precise to state that argument specifiers can be 'any
operand accepted by Gnu Asm Syntax' (per [0]).

[0]: https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

> + * libbpf is currently supporting three most common cases:
> + *   1) immediate constant, see 5th and 9th args above (-4@$5 and -4@-9);
> + *   2) register value, e.g., 8@%rdx, which means "unsigned 8-byte integer
> + *      whose value is in register %rdx";
> + *   3) memory dereference addressed by register, e.g., -4@-1204(%rbp), which
> + *      specifies signed 32-bit integer stored at offset -1204 bytes from
> + *      memory address stored in %rbp.

[...]
