Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146DF58AE9C
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiHEREm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiHEREl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 13:04:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96A26E881;
        Fri,  5 Aug 2022 10:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2H2UEfx0tkGhXk2nkED7KlNo7O2Eno1i5o+3wBKwUxN0/pA0GP/O/7WZlCS2ASnnO5XCLM5rAVEcHjS/3WFBcb/o7eMnzeT0FULf8hAJxYvnmfo8wcCq7PeSAiBxjJUEye5CAD6uvNUKb53/8tVRImVq7exWpQQ5bqXCEOIOl18DDRHTSnMiWkOj8iDqQPcJA+Dqq/DJ780baI7nJR/9SFXTPCZwPiIMiFsVqrT3hp29g2DFJCIJDm0YXcm0M9FpJaquZaCVB1l72OQw9O+NedWj9uaOgaaiiDU+8ZEeepz36yVl3bno7eWPHP46J7g/C9oo+BExfmc6DtN2INyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAoyTnd4Mu8j11oZF5uRkgoQu/qfuGYVKtJH48iVSlY=;
 b=mUxI1M5QJj60NF559gFaLWutsqiDfgLWIvE73zGpiyZ84hMd00ih7AOpsb1YALfnA0CRhfwFKTn9HjHssjEy9SAIQQzAHoFXVO948XSOWiI0MD9ndzeDRfsJHCQUmkMSqcWnmsLsjNokj9B0q61wizA2Sl4EP+5xQzd6nVCLhCvyMAc9xM6eLf5BkdiBeInVI2Ojot6Nmlu2o1sGbuUeyq4FKX5oQhhfa7fhSo5JApQfMz3M3Jq1QeXDLL05NLg2uTXv4MeJ6auFoGdtsztdZeQR4HoguDC4AkJ47zC+Enoc7Q8u1S1PrjsJU1yn5QGiNAsKbo2LxFS4k8Ki7nrFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAoyTnd4Mu8j11oZF5uRkgoQu/qfuGYVKtJH48iVSlY=;
 b=Fl189guTxeUijSieMemu9wllfKgbzthi5PYQz0NGdbPShNpC/Vc2kG0n/6Dzn8W9ufk/RxjMo8HgCPF3X7OBp55/Ri4GNyu7KQM3UkHBgKbsuJymORe3LRgeoH0qXxp6Cw1+Sdzh0VdOvuOslnvsYGOfpfgFy3gjL0TwWowiSZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 17:04:37 +0000
Received: from MN0PR12MB6272.namprd12.prod.outlook.com
 ([fe80::5ce0:108d:9127:feae]) by MN0PR12MB6272.namprd12.prod.outlook.com
 ([fe80::5ce0:108d:9127:feae%4]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 17:04:36 +0000
Message-ID: <86921fe7-6a6b-2731-b09e-a6e03f38a6b9@amd.com>
Date:   Fri, 5 Aug 2022 12:04:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com
References: <20220804192201.439596-1-kim.phillips@amd.com>
 <Yu0sT6vCofyWiAMI@zn.tnic>
From:   Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
In-Reply-To: <Yu0sT6vCofyWiAMI@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:207:3c::48) To MN0PR12MB6272.namprd12.prod.outlook.com
 (2603:10b6:208:3c0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4eab476-aec6-4edf-2152-08da770493b3
X-MS-TrafficTypeDiagnostic: CO6PR12MB5394:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCj7qQQp2rGgJLAk68EiO8WvEkbLCB4vFGpfU4l6ig1o3f+fqp0dQrBrP0DSLWRbN2NA/HzmvUaskGCcIovuCXsJE+JshKHVOXTML4jrCI8G9bNbugJlDAQFX5zJng1ypsT2WEqiT9zs1xQZrDJDypGo4+gJOr98FaZkZ8gGBU1G10ulGgD3oB5QoFTX4cc2/Xxz6+dzi0nQ3O2IyN4HgqEy7N2TyrGEuqkoelH9AppDZOEkuGZkqCbQzijTdI4TkLB1eG+wScwo1wP9TTOMaVIX32aplPrpz9BbmInhUQyG0l3k4sjiQQpHHI4G22lX7kdmTRzQDXCkUs7pV8AJa3/5JvbVknm9RtEM0dii9+qxHRm8yzTOo1qp74dvay7gkjX9HHzc4ho1IfFCszMHvtlTg+yziMTkD6DCK/pTG71NH555w9LZW1TokC3Byer2+Xj86sPhyNaTyjIjUKD6SJ9Px8CGSvFtTyxTBYoxMJvqFfq6RC84GtawOmDNi6KJfhPkxVKXpnv43YZwZgOXrwZMcMUwwO4eIJxPpOLx07rjWUAcGuwTxPSSsLOjxuzaCK9Q+eOCyX2noOTTcmwWWFipdyfoEc9hbsaM9wsbVosY8yJlVrB+NjKTpttYNkuf7QI6huiIC9wTpdK8ZcKtM9x47Aik4TD3ODBsuZR3aSAOoNYVmDhE0dQfO1ePUoWkdFMEy+1GF84hkOTb+WKy56lfkq4W+8jqVNC3xrRKkn6YmVyoE9k+VgzBlGAkAd4TSt11cD9oPmzYuHb0cvFGUwjFum+rbKEz/DlTxvlwP3U15exDZmvVtkgp0R0g79WkXpzpFUxHLTC1/0KPuxLvtYPKWjdkLmQfP3fwKfkYAgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(53546011)(6506007)(38100700002)(83380400001)(44832011)(2906002)(41300700001)(186003)(2616005)(66574015)(6512007)(26005)(316002)(6916009)(478600001)(6486002)(966005)(66556008)(66946007)(8676002)(36756003)(86362001)(31696002)(4326008)(66476007)(31686004)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJOaFNwRFc5VHVLMkptU2hoSFZ5NHlrdUx6SkJRNlF3NDcxMytYbnp6WkE4?=
 =?utf-8?B?b3pkMFdtWE50RmNabHBGZEJ4cVk5VWVJc1VVVW42T1ZEYlZkVnhZYnZ3OW9k?=
 =?utf-8?B?N3ZFcDM0OWpuM0haSng5VjRnSG5IWDFXMzFKY084a2FJSzJKL09OMlpoSzlZ?=
 =?utf-8?B?VHp2Z0t0Zi9ITER0ejZvZ0VGSCtoMzVKQlN0Q0k1dmtkSlhWZGRaWXUwTEth?=
 =?utf-8?B?ZCsxWlcycVFkY041dUwyVi9SVU4xQ2UwaGNWOG5qOGg2cFlFanVPamtjZmNi?=
 =?utf-8?B?N3BJSlUwWFMwU3B6ZktrVUVUbmprYXBISE80VmJpVXpZTTZyby9JenF1U3Fi?=
 =?utf-8?B?UHJhLzhOa3E4NFJlQ3NMeWdxSzA2dllrVFJKVkVMK1JYd0pEZ0N1azVNVEpw?=
 =?utf-8?B?bEQzTzUyc0xnMk5mUXNVZFdCMEN2RzJKRkRkdWJXMWtKYXZzWUpNcW1SOHd2?=
 =?utf-8?B?Mkg0SzE3QmNhUHBQWVJCelhqeHdNQmJON3UwMEc2bldaTHVMTytGaHBQMlJT?=
 =?utf-8?B?dGJpdXczeStoR2lhQS9reUQyRFFHam80Vm1XOGlncUIwb0huQU5YRld0SGZR?=
 =?utf-8?B?MUp6a3F1NG8vRzBuU1NpNUdyQmI5eXdTdnRMMjhJK21ySzlXUWtjUTFEcUhZ?=
 =?utf-8?B?azJuVTM4L1g2UTY3YjBERlFkYk5MUVE0WEpud2hMQm1oQURlMTVpelNJMnpV?=
 =?utf-8?B?cUJTdDR6SllMdHMrcnJpc1E3bnRnd3gwV2E0RitZVkNQZm1TQWlhWndDdzRv?=
 =?utf-8?B?dmszQk90cGh5TGNjdlE2clJDNFh6MkFTQktGMVlkSlFNdUxwemFldGlCY01J?=
 =?utf-8?B?N1ZqRVF0THlXWnBUMmsvYks1Zi9wWTEyVGE5UENwS3gxZXkzQjluR2g2N2J5?=
 =?utf-8?B?Rk1IdUQvMlNzU2RLQXhzOE5MbDBRazNkdWtiRDJNRVVzNDJ4R0xQa3lIUG9n?=
 =?utf-8?B?ejVFYllZc3MrL3NZUXRJSmUrMHBNRituNHdkNlAwMnMreFZ1V2tnQTNYeWQx?=
 =?utf-8?B?VUxLUUo5RWVqeHdIeDFyTWRQQ0hWVjBpc0ZwRHZUYkVEbFpZYnBlaFNDUkp2?=
 =?utf-8?B?Unhla1ZSWEZ2YjFtSGJ5T1RiL2pkYm1hMzd1bHg4a3NGUHd6SUhDTTdyallW?=
 =?utf-8?B?WDlRQVNqa1ZDWjJ2YmdFNU9HZlU1UTBuWnJJekdlOFpSaU9mV3JUelBtMUZ6?=
 =?utf-8?B?ZWhWZzFMVW9tUEhkbGsycnJKekpJa1l5ZldsaXorTjRJS2d4VlRaUmt6M3p4?=
 =?utf-8?B?RE9EZUl1ejhTTDl5ZnpQeEFneklvN3l6Vm5nZWlhdXFVZ05WSWpBL1JTd3E2?=
 =?utf-8?B?MlZhMzR0NnZqR3FWS3g0Uk5ieHIzU2FDRTRwRFoxVFIrUmMreDFUR2IyQUNr?=
 =?utf-8?B?a1RyOXZ1SUVXQ0g5RGcySm1wWGlTc3RneGVyWHVGeVVhNjVnRjFkMzF4WWwx?=
 =?utf-8?B?c3kxQVByVnpmYndwVGN0cjBHUlo1L3Z4M2dDODEvQldlNGs3YnNlL3A2Z0Nm?=
 =?utf-8?B?UDlvempRMktsK2xJT0o0QVI2Y2hrdU52SmJHZzQvMCs5dHFhenBZWW1qUlhT?=
 =?utf-8?B?RWJ2MGZNQWJuazRQNDZuRHdld3dmZEhnYjlrbm8yQ0F6dkJlQVMxdWJSTFFY?=
 =?utf-8?B?K1laSVZqRkFLTVppMzJBVDMwdjRlK3E2cDZNZmxuSzdiSEJiQ1BlL1lUV2FU?=
 =?utf-8?B?SGtTRXhmVXhTSSs3bkUvUXErYzhhVHZ5UHFhMCs4ekRaaGFPTWltQnROeUdG?=
 =?utf-8?B?Q2NxdTJjckVjUUMzQnZ3K3VjUHlJajNvVzlCRHVvSDExOU1yT3dBaE45K0RE?=
 =?utf-8?B?emVuaHV5RlIzWTgyZVFIV0pGOGZoQ09haElGMUM2b0FKV2dCMTJHMVpONkY3?=
 =?utf-8?B?Slo5WTNLblIxLzZKL1dsWHV4WmdZQlFqRWxtMkNJaGJjTFBSZnBrNWZ6aGc4?=
 =?utf-8?B?bmUvZmdjOW5mbUVudFAwdnVEYnZKQlJnd0NKVU9vTFdGYVhNRnR0UENWRjhZ?=
 =?utf-8?B?K1RJaEYvUEJvK3cyV3Vtb0RPb2U3S0JtYjZyS05WbElHSXJObURJcnRUcUEz?=
 =?utf-8?B?WElWTVZMZnJ0TXB4WFY3Y0JpZDkzTnFEamkzZzI4L2dWYXZ4MGZjblRNVno0?=
 =?utf-8?Q?967Bk9nX1SbmnfVvCIuAE6kyU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eab476-aec6-4edf-2152-08da770493b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:04:36.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTvUiOChFTUO6i8NEnZeF2GgNTSIE73uIjbSeJ21TrCpkwMtjYieExCCiNhmhuTFfE0k9kziwZnu2NV9xRt0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/5/22 9:42 AM, Borislav Petkov wrote:
> On Thu, Aug 04, 2022 at 02:22:01PM -0500, Kim Phillips wrote:
>> For retbleed=ibpb, force STIBP on machines that have it,
> 
> Because?

See "6.1.2 IBPB On Privileged Mode Entry / SMT Safety":

https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v7_20220712.pdf

Did you want me to re-quote the whitepaper, or reference it,
or paraphrase it, or...?

>> and report its SMT vulnerability status accordingly.
>>
>> Fixes: 3ebc17006888 ("x86/bugs: Add retbleed=ibpb")
>> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  4 +++-
>>   arch/x86/kernel/cpu/bugs.c                      | 10 ++++++----
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 597ac77b541c..127fa4328360 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5212,10 +5212,12 @@
>>   			ibpb	     - mitigate short speculation windows on
>>   				       basic block boundaries too. Safe, highest
>>   				       perf impact.
> 
> You should put some blurb here about STIBP and why it is being enabled,
> where present.

unret didn't have it, was just copying unret's entry, but,
ok, will do for both now.

How about:

"{unret,ibpb} alone does not stop sibling threads influencing the predictions of
other sibling threads.  For that reason, we use STIBP on processors that support
it, and mitigate SMT on processors that don't."

>> @@ -2346,10 +2347,11 @@ static ssize_t srbds_show_state(char *buf)
>>   
>>   static ssize_t retbleed_show_state(char *buf)
>>   {
>> -	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
>> +	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
>> +	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
>>   	    if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>>   		boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
>> -		    return sprintf(buf, "Vulnerable: untrained return thunk on non-Zen uarch\n");
>> +		    return sprintf(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
> 
> Well, you can't lump those together.
>  > You can't especially say "Vulnerable" and "IBPB" in one line.
> 
> To quote from the BTC paper:
> 
> "Software may choose to perform an IBPB command on entry into privileged
> code in order to avoid any previous branch prediction information from
> subsequently being used. This effectively mitigates all forms of BTC for
> scenarios like user-to-supervisor or VM-to-hypervisor attacks."
> 
> Especially if we disable SMT only on !STIBP parts:
> 
>          if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
>              (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
>                  cpu_smt_disable(false);
> 
> If there are AMD parts which have IBPB but DO NOT have STIBP, then you
> can say "Vulnerable... IBPB" but then you need to check for !STIBP and
> issue that on a separate line.
> 
> I'd say...

Those messages only get printed on non-AMD hardware?

Kim
