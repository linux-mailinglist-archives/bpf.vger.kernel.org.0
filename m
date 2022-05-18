Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29452C55F
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiERVIi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 17:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbiERVIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 17:08:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58DBCAF
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:08:35 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24IKi4xo012652;
        Wed, 18 May 2022 14:08:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G9kZth4ukSksgeVvTk3FL3CX3vraK8Snhx4mi/Bj92c=;
 b=bktaxmkk2/NQ9W0DHXwQ3yJU8EXNQBgG80Znes2yfhxT/rQRSM6pLvJSNz9cB2LPTzNy
 R7jtadMTSijJgWKIn/Tvffx+F+6NIunMP9IDzVPqBvIvgAEwRArIytLpyhUQOJITK/LJ
 x+wLIgfUDyPtzxEDyCetb7pKuyFlp/4d67I= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g4myhqbfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE2CNBt8oYwH+dC9to5W2EBrbnjoybch2HKTYki51N/Ggt3hBE167dS5RI1jNDk4+vh2BD5GUdJPE6EVDRSY13uP9bknkZFtRMydFFA/XwqvP+7qQDmRsdvXXGXvOSy4LDrW+XZayvHhSB4+Eb+7cQ7wUhocnEX2I+U2rxste1cOdVihLJA9tQuNczguaD3nRENB0czgW7Hy2e4NEZBOKC66kFDZVy+LPEWLgELrShw37tL/7R8hTSyaA8fWO0UluAoNNxOt/ckUqUyqNz3Y7Um6CoSxggss1oX7LjKeGibkjY8zV/Xq53fw38mxet8l3J4uRDpGPAYO/x5RJPcJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9kZth4ukSksgeVvTk3FL3CX3vraK8Snhx4mi/Bj92c=;
 b=kUQdKomnD1Rhx5rG/87oATclkkdI4qfk1VC7qhUAFSP+x3uDC1ITjJy0onfQixxGdK5SH97zBm7Hy/SywFIFjUaXMsN+xBlQ7iRsdQdSayFVzCs08g653fhCfoUN2ktnKVi9dnwgdygT45GBiu35JRX7JQ2Dwp1BdmbwnQo96/PeHl1JiqOmLQQQ36EPkExQMzJj/9U3O/cHy4K35XW9EYhJcjBHhw/BeFqtIvJoIjSXslJxNtpwkI+M3Ad4VXD2dnnqVqLTIKkTNdLOWr7GppMxXd9T45aNkpocZiGnZ/Hj3OcBHD4EhJzPS/sgGZ5ZHB8a980Z5KUImfSnWPTEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4228.namprd15.prod.outlook.com (2603:10b6:5:349::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 21:08:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 21:08:17 +0000
Message-ID: <77d65513-8318-2df2-8990-4bc02bf195f1@fb.com>
Date:   Wed, 18 May 2022 14:08:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 08/18] libbpf: Add enum64 sanitization
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
 <20220514031303.3243922-1-yhs@fb.com>
 <CAEf4BzaAXz-DxvrjB94vs7Zv_y15-2kbF5528aPvpCru_f7=Aw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaAXz-DxvrjB94vs7Zv_y15-2kbF5528aPvpCru_f7=Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:405:75::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934fb9ce-84c3-4260-4207-08da39128752
X-MS-TrafficTypeDiagnostic: CO6PR15MB4228:EE_
X-Microsoft-Antispam-PRVS: <CO6PR15MB42280362E4ABE81D7B88F0A9D3D19@CO6PR15MB4228.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgcpep09wuRl1/ZwXFMTjVgw9/MRuWxQRsfOBnZoCkubZdPhtXA6nfnT9z+N9VriQzmkRZCGEWAwsOUhbYzcMeJIW0850ZlSQmPOKfyoNEQYLIJfSChbKfEv7hXdGwc18XW2Dat22mFXkpFH9TyHXZE7YOaB5ipSJB4Q8SdKkoBfyFjcxu3zedMcbLfm8dgPSA9jihHoJwuu2hxeFY4Y1LrJgW31cl79/Rdi9+GZgC4jI9+AYJJo2282yi3G7A0QfckepcvT4D607ollVRxzHdwSF6okfS82yMdaCat2IdmwKP/oFZ5EzGzEYziwYQbHxf45MmjUhRHRAJ9cXvw34g6PFmjVvXydRZUXQ54xq6evgxBjFbPuL5Hbjh0aHiBncrUNQhrkJupuCUJUK3rTdZEziFsv643PLDGahKx80vQVngUVGSPbrSEefgy0fKqeCOP19xqo+JXID2peWVkvsdDzzevmtfIp9XNIMOq4tjvJ0SxXTNwDyZ72ObHc5wCfaXFXUXFOICOHdRR9a/WmyYpRVG2eQulRhvbWdVNrrALjYHcdySWoOsLPFEofFtQBsEXDqDrMy14HfUwWKYqTJPUDi/Hpo1l7bCQzmIl+s2eDdvdzy0DpWBRYlf9ckIYhIeMyot62E7kKFq6LK07+ugB1/moGUJM1ASJGBvFqvzi4mrZhd9hkZvpTaay09QSSKZx1ygOsWvsMl9VY/CeCvBYIaoEx5TKwe22KJ8kKbgQrOC8JTVmEJt7ZSCgZK0I0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(5660300002)(66946007)(6512007)(6506007)(508600001)(38100700002)(2906002)(66556008)(53546011)(36756003)(31696002)(2616005)(54906003)(316002)(86362001)(31686004)(8676002)(6666004)(66476007)(6916009)(52116002)(6486002)(4326008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE84K3lpUzBwTFJUL2phdWQ3cjVVSXpjU0Y2S3pHUVhWNTFxMlVpV3JtQ3Ju?=
 =?utf-8?B?ZFdlZitUcHNBck04UDRmZ0htdjd6Y3NuVUhGQlh1M0ZCVTVscllJVFpCY0RV?=
 =?utf-8?B?WHpHSkg3NCtLek9uWUwrdU1LOGVkUklQWkFySWVPMjVkN1I3akNCcmEzL24x?=
 =?utf-8?B?OHRkSldETDZIUnRMUFRvckdaK1h2eEYvaTVGM21DTGRJWjN1NThGY3Q2dGhZ?=
 =?utf-8?B?MXNYZUh5NjhPU0JaaTlWbmZiamJaWXE3UkdNQTgrRHpyRkJCYUt4eGFGbFZ2?=
 =?utf-8?B?U1hVeldRdktWbWd6OGFGSTk2M1JaaS9mdjZTWlBpQU03bjNiKytjK0IyOUsr?=
 =?utf-8?B?OG9YRWR2UU0xVklQUXJhTVJ4L2hTam9yQ2ZnaHpNRXZTMFd1cXRLV3FTUC9Q?=
 =?utf-8?B?emU5dWRmM0hZQTFpdGZLU0NPR1hRRm9UdHQ0THcvWVVsSDJwenVNend1bThm?=
 =?utf-8?B?QVVWUTZkMExSUDZaczRNUU1vRm1HZnRSSkp5ZkltQ2wyek1OUGZJbDdDd0ZI?=
 =?utf-8?B?eDJGY2JFSXRDS3FVTHk3Mmk4djgyclMrM2V1RlArUEQ5QS92cXQzV01oSmRO?=
 =?utf-8?B?SkFiR1pYSlpaOUFHRXlxVXdsZFZLSEZCRVZlVHNjTm9LWEljSVZ0cW1Sc0ps?=
 =?utf-8?B?QVltOUR2QnBva21kZmhvZ2FraHZDeE1JRlltZTFBSlk4RkUyc25pYW5hM3Zp?=
 =?utf-8?B?ZTBsZ004MVJ1TDY3MGJGVk5lTVhDUkNMS0ROOVkyNWcvVytYZVpNWnltYW1V?=
 =?utf-8?B?ZkVRNGZGcTZmWWZiUWZQTXIza3FmOE44OFpXS1ZYcWxkdDVUbVBBYWJJOWd5?=
 =?utf-8?B?aEU3d3Jmb0hlMC9iZ0ZHOURwaFVURUtOQ0FsWHJiUTNNSlFyb0sxYnE4VFNm?=
 =?utf-8?B?Q0oycWt5UWdlUE5UbDN6Z2RpY2VneFhzSWJjV1k1RDF1aFhpR2JHbVgrVDdt?=
 =?utf-8?B?U0V4Y015VGR1Y2habW9XK3hKWFp6ZDZPaVVPajB1UmhoTzBUV1hLN1V6T25u?=
 =?utf-8?B?dmFsemErcDNWMlN3ZHhTYUdCeE54aVlscGlmVU9jRTg1Uk5YamZjSC9NZ0pq?=
 =?utf-8?B?S1ladC9YSWdJNlp2N3JaWkNTV1FFRklmd0JGazZPdTJYK0dVSTJtMWJhMnh0?=
 =?utf-8?B?UnNnb0hLSy85VWxLNjVycnVWclp5MjREc3BDclNCY0FEUUFvKytTNFhaU0wv?=
 =?utf-8?B?WExKWWxLbTVhYlJwVlM3WUZZYjJ1YjNQUms5bmlMZUd6ZTVhTUtLTm14M2pS?=
 =?utf-8?B?dXVYT2g5aDkydXY0SkhIMmFqajdCSkt2QkV1OXVLOXd2VU1VdU9XZ0VXTVFO?=
 =?utf-8?B?VXhGYnhQdEE2bzJLNTVmVjFXSHNDdFdMWkNaalp3ckFxcEd1bzdCVnQwMFpQ?=
 =?utf-8?B?d0VabzFLM2grd3JvY252N0VmNFNGNWV4SHRNcmNZaFpRWmtiVkp4WWJ6ZmxS?=
 =?utf-8?B?Zll5cUZPbTFpMHRScS9NVlRwR2cyemh1YnQrTXFFb2tldFNWKzE1TXpIR0cy?=
 =?utf-8?B?cHlOcmNFUUpRR091Z0VncVBqTS9VWTdHTkU3d2ZEc1kwbmdyV0NrekI3NjYw?=
 =?utf-8?B?b1gxRkxtdnlzV1VmT3Nzcm1ZRkFWcnlQQ2hnZk95SkZ1T2o1Ni9WOHc0Um8r?=
 =?utf-8?B?WTJUbkxaaUx4YjNmS0d5UGNlZGJpelhVd2NIcEh6dGd5Y1AxVUhOR004cXJP?=
 =?utf-8?B?OEVvK2J4ZUozK205NHU0bEdPb2lvRXYzOHF0Z3VHRXhIY1B6SzRScU9UVXJ5?=
 =?utf-8?B?UkxTaThQaUdzWnFRb0FlaWo2K0NpbVFyak9qOVBjMU9FT1dpazVrV0dVY1Q0?=
 =?utf-8?B?Y0VEeG1JL0I3WTlidlpnd2dsd1NSeTIvNTdMc0FZdGVCSHlaNkgwZG5MVDF0?=
 =?utf-8?B?aUliZDg0UmJoYXF4MnZySmE0Q0VWdTBGcXBaNitZdm9sVGZwd1VzRFU5aGNw?=
 =?utf-8?B?WHVXN0owemhtRWpTOTYyeEwyRnVqV3VPR3ZEQldVVXVVbVNUSDN1SXFOOUVK?=
 =?utf-8?B?V1FlcS9mL0lBM283ODhuU1M5UWlxVXVjVDdWNnVNeG9NTGcrY0dicDNJeFcr?=
 =?utf-8?B?bXJFaHlJR212SGlyQnFYakRURTJYZVZ6UmcxSndDYzNvM0hYSU1yUkxTNkNs?=
 =?utf-8?B?S0xOUUZHM21PckhiK3NLY1p1OHVsb1FEVVVtNStBQk02Y0dGMzc2N1ZjSFRi?=
 =?utf-8?B?RHRhakFLK2tXLzMxL0FaeVAwRTNNOXZxRjFGQjUwL1pQZnlNNnMyNFh6Vytw?=
 =?utf-8?B?ak5QbldTVlZPcnFVYVUwcHZ4RXRNNHpIRlVrWWRWeEZ5Zk9OYVBUV2x1SHpl?=
 =?utf-8?B?RjQwTHN2Z3orbFUrZ1dBeTd3c1FhaHA4VTI2UHh3TkYybktBOHhJVkpmQ3lE?=
 =?utf-8?Q?nuBcVzGwFk7AWSJ4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934fb9ce-84c3-4260-4207-08da39128752
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:08:17.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeGGUn+DwB54KbUvFCfRqERsCIvgf27BIjWITVe5NN3ZQdvqptLU8JPq59nz9cL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4228
X-Proofpoint-ORIG-GUID: Nr56cGcuEAqbLzoxdRYM9ziMwWBgYFQ1
X-Proofpoint-GUID: Nr56cGcuEAqbLzoxdRYM9ziMwWBgYFQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/17/22 4:25 PM, Andrii Nakryiko wrote:
> On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> When old kernel does not support enum64 but user space btf
>> contains non-zero enum kflag or enum64, libbpf needs to
>> do proper sanitization so modified btf can be accepted
>> by the kernel.
>>
>> Sanitization for enum kflag can be achieved by clearing
>> the kflag bit. For enum64, the type is replaced with an
>> union of integer member types and the integer member size
>> must be smaller than enum64 size. If such an integer
>> type cannot be found, a new type is created and used
>> for union members.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.h             |  3 +-
>>   tools/lib/bpf/libbpf.c          | 53 +++++++++++++++++++++++++++++++--
>>   tools/lib/bpf/libbpf_internal.h |  2 ++
>>   3 files changed, 55 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 7da6970b8c9f..d4fe1300ed33 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -395,9 +395,10 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>>   #ifndef BTF_KIND_FLOAT
>>   #define BTF_KIND_FLOAT         16      /* Floating point       */
>>   #endif
>> -/* The kernel header switched to enums, so these two were never #defined */
>> +/* The kernel header switched to enums, so the following were never #defined */
>>   #define BTF_KIND_DECL_TAG      17      /* Decl Tag */
>>   #define BTF_KIND_TYPE_TAG      18      /* Type Tag */
>> +#define BTF_KIND_ENUM64                19      /* Enum for up-to 64bit values */
>>
>>   static inline __u16 btf_kind(const struct btf_type *t)
>>   {
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 4867a930628b..f54e70b9953d 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2114,6 +2114,7 @@ static const char *__btf_kind_str(__u16 kind)
>>          case BTF_KIND_FLOAT: return "float";
>>          case BTF_KIND_DECL_TAG: return "decl_tag";
>>          case BTF_KIND_TYPE_TAG: return "type_tag";
>> +       case BTF_KIND_ENUM64: return "enum64";
>>          default: return "unknown";
>>          }
>>   }
>> @@ -2642,9 +2643,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>>          bool has_func = kernel_supports(obj, FEAT_BTF_FUNC);
>>          bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
>>          bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>> +       bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>>
>>          return !has_func || !has_datasec || !has_func_global || !has_float ||
>> -              !has_decl_tag || !has_type_tag;
>> +              !has_decl_tag || !has_type_tag || !has_enum64;
>>   }
>>
>>   static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>> @@ -2655,9 +2657,25 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>>          bool has_func = kernel_supports(obj, FEAT_BTF_FUNC);
>>          bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
>>          bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>> +       bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>> +       int min_int_size = 32, min_enum64_size = 32, min_int_tid = 0;
>>          struct btf_type *t;
>>          int i, j, vlen;
>>
>> +       if (!has_enum64) {
>> +               for (i = 1; i < btf__type_cnt(btf); i++) {
>> +                       t = (struct btf_type *)btf__type_by_id(btf, i);
>> +                       if (btf_is_int(t) && t->size < min_int_size) {
>> +                               min_int_size = t->size;
>> +                               min_int_tid = i;
>> +                       } else if (btf_is_enum64(t) && t->size < min_enum64_size) {
>> +                               min_enum64_size = t->size;
>> +                       }
>> +               }
>> +               if (min_int_size > min_enum64_size)
>> +                       min_int_tid = btf__add_int(btf, "char", 1,  BTF_INT_SIGNED);
>> +       }
>> +
> 
> we do this search even if bpf_object's BTF doesn't have enum64, which
> seems overly pessimistic. How about we just lazily (but
> unconditionally) add new BTF_KIND_INT on first encountered enum64 and
> remember it's id (see below)
> 
>>          for (i = 1; i < btf__type_cnt(btf); i++) {
>>                  t = (struct btf_type *)btf__type_by_id(btf, i);
>>
>> @@ -2717,7 +2735,20 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>>                          /* replace TYPE_TAG with a CONST */
>>                          t->name_off = 0;
>>                          t->info = BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
>> -               }
>> +               } else if (!has_enum64 && btf_is_enum(t)) {
>> +                       /* clear the kflag */
>> +                       t->info = btf_type_info(btf_kind(t), btf_vlen(t), false);
>> +               } else if (!has_enum64 && btf_is_enum64(t)) {
>> +                       /* replace ENUM64 with a union */
>> +                       struct btf_member *m = btf_members(t);
>> +
> 
> so here we just
> 
> if (enum64_placeholder_id == 0) {
>      enum64_placeholder_id = btf__add_int(btf, "enum64_placeholder", t->size, 0);
>      if (enum64_placeholder_id < 0) /* pr_warn and exit with error */
> }
> 
> and then just use enum64_placeholder_id for each field type?
> 
> It seems much simpler than trying to find matching int (especially
> given potentially non-8-byte size), so it seems better to just add our
> own type.

Besides this implementation, I had another idea to just add one
int type unconditionally for enum64->union member type. To avoid adding
this type unconditionally, I added the search part.

Let me try the approach to add the new int type in the fly when
needed.

> 
> Please make sure to re-initialize t and m after that because
> btf__add_int() invalidates underlying memory, so you need to re-fetch
> btf__type_by_id().
> 
>> +                       vlen = btf_vlen(t);
>> +                       t->info = BTF_INFO_ENC(BTF_KIND_UNION, 0, vlen);
>> +                       for (j = 0; j < vlen; j++, m++) {
>> +                               m->type = min_int_tid;
>> +                               m->offset = 0;
>> +                       }
>> +                }
>>          }
>>   }
>>
[...]
