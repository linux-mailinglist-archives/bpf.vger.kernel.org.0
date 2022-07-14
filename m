Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4D574A24
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 12:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiGNKHX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbiGNKHR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 06:07:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8151428;
        Thu, 14 Jul 2022 03:07:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E9YptM015127;
        Thu, 14 Jul 2022 10:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mEr4E85Vot8Y7AKgbnNHVwJXGvZ8jhEjPpcu1Dr1Fcc=;
 b=yIH1HB3wNF+kg8bHK9yBLd07PzQIaTXI+ZjsyKgjaUD/cSTPzreHyU9AQSxyU6Rc1sd/
 CnSLGOQamSmolCEz77fXRYDQc+DwoMJjoIeW0jrOD8R9Tgbe1RVGXhrgLtGFTts42Bj8
 x8zvXrpnsuDmnT/CIJ98t814mMciXOJlyW4hGlgG237grv+GCgEwZod9MUAbD3aVWOsj
 yarlQ0hNkcivP81hHyc4eSYeC1C4+QF/I4MIW7F4k2Bjq+xzQeRU9tznn9PI28cBQdQz
 2kcFl+jo1yB2F9p3KR2TRNwK7jm521vsh9oPXPhRpN5Ykc5UwmvGP17ieTTJul7o3egz bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg4jab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 10:07:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EA7AuT033208;
        Thu, 14 Jul 2022 10:07:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h704594t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 10:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8S3k2pxm3N05m+9W9/c/b0Pv3DLfeulq0TWD0lHuJG4gzfLgWOzeMG9x9OjG6tA7oZb8M28yWmtz/Wd9otWyRcvoNeG0/9EuVWsLkTOCwCAzR7irwjIcWknJHzdGw7VSj76irRtiLUyXfmoHBAowW/4aKPRoEp+oH1QupPA2Ng1uNDNUD5gKCSqNNsGs+W8SB+uyUzK/LNgYJD3KS7DTLjfKk1t0wRGIj4jU3kgrsn7jhExtPrqZLV5njP51F/BoDVXNNlDW5MoTnKas4YyCEFe3vhIWT2MbuP7yA/DmzpfVmoZ6tdr/WcgqOkH2n8483LmKc6Y5THmtkYrtMhZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEr4E85Vot8Y7AKgbnNHVwJXGvZ8jhEjPpcu1Dr1Fcc=;
 b=Bd2BSXOOd4L9SDHBG//QHxL1/plVQ+NVwdWQHOsn3e/Ns3xMt8NwGFddUeZaJj7dTibaogrZQ7ux19276XsYImEFD1yhS9fSK5KpS9J/wJLfUEx+0rzUGsgef37TFtQvnOaPKhKTLy2oMsGrlm8bVNfagEDIQxzH4Ao1a0sVHrtzNFtYWX24q1IXE5P4KKIoim8HcFs31ESyXqzVkTFiU5cZVj1pzNhETQptqY4tkZlcrqD/NSQoTwRnEYJyfbql8yg28Rd0rieVGugVRzHzOjuxxdZfL+mkxuXFm/5KY70C6MR30utonEo7+mwmhK9nCMKnrS/5G+n7x4UCugcQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEr4E85Vot8Y7AKgbnNHVwJXGvZ8jhEjPpcu1Dr1Fcc=;
 b=Hcydfih8rUAO1l6H8fXcvYrix/1mgyuSe7+TVBHz0SgKymn6FDyC6sI4hg2OFDyzDaNeAALqYOnKjNZkrJyZNqkHjTsrM2pqawVu7xxtewSFzWZNPNKHsCoeNJxrBc98ctfA0yLdBKrOSaS+BS5ivWpvq8vN+wOTEZkL+krQx4o=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 10:06:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 10:06:33 +0000
Subject: Re: [PATCH] bpf: btf: Fix vsnprintf return value check
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Cc:     Fedor Tokarev <ftokarev@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220711211317.GA1143610@laptop> <YsyZY/tFm3hi5srl@krava>
 <CAEf4BzYGjNaqL4h8=4Jw7O_xxMfy=TbUg94VO6RZT5wOtV+_wQ@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <ef44abe0-81fc-9c97-a4e4-2b3ba19cd84f@oracle.com>
Date:   Thu, 14 Jul 2022 11:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4BzYGjNaqL4h8=4Jw7O_xxMfy=TbUg94VO6RZT5wOtV+_wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5456b57a-7abd-4088-0a3c-08da658087b5
X-MS-TrafficTypeDiagnostic: MW5PR10MB5668:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRfsByopW58ql1vegIvJF2veIMviFaM3SqU1FbgWJZc1CxdOmdbYriQfRz1ehEc5qdCZuHoUQaI8j2RrIKmVzD8g8MX2BIMo9NxcV79k8AZKgpuNYJ4FjiLIQSt6VXkM4o0OLvgVj2pblKyvCZib4+o2Qr6mFU4M8CvZQCAMqKioJUx20x+43holT7oPlhEmc4+2HqCFNvh4fKUvlyay4Mg+F+3QSW12LiP5fAhQABKB2uVIeg5eDRgwywJ3c/YisspGJXYP249aNR5KTvaULSceNDwfshsSneB/Po+aQ4Uw/HjHnQLDqKn85KDB+ykDaBf+ugKpx3c/RBNRNq4YxiIb/CGs6Ljn8HHW5s4s5A7ML3D2tYRpRK5essyeJRr6hA2kZhnBLtp/EVE5QojXwFU7r/qAZnTN9ygMU3VeMC6/G65RpbNxmWN7oGkzCRve6G1qdPlZ72wW4kfgwmxILjK0UDSB0bYlYBxpmesoqoTvxE70BhM2SKaTH/K1xRpdlqq35yxEJWmquHf4FMTVRpdgj9SHLD40QswbEi0OEatl4OK9aegj2aRW9RhJWyhaBD5WdbN2LtFQbGOuFJuS+wjSjBr8BuNnkEkSrkLXizGsbgrUoAT41RQdl1WffVDlWlogVEdEjSHE2y4fWIAxjx47HD5/CFOGl2ZnRoke+rXJhV/Pp/X+6dfXcjDi1Lu1u9WfmHLR6aO57Ae/4moqP3bhun72z/QSvWK1gTnikqnsIIGFZeS+LDa4bzdOod+VzyfB/Vpd2SOCJK0zqf//q4TL33d4w5lriIYZ3iNCtBpohqvVBNU0jVnk77htH9Z6NC1Owl0VtQmpZ6Lqyqlt43EaVX1WDZQ9CiYh1y/6Yn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(346002)(396003)(376002)(316002)(110136005)(6486002)(83380400001)(5660300002)(54906003)(478600001)(8676002)(2616005)(6666004)(52116002)(2906002)(53546011)(8936002)(36756003)(6506007)(41300700001)(31696002)(6512007)(31686004)(86362001)(38100700002)(44832011)(66946007)(66476007)(186003)(4326008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWF3U1E2VXdKTDB0SVd6cE1nK3duaWgxQVg0RXA1bGFUS0hUZkpEU24yYVFN?=
 =?utf-8?B?KytNWGdpUnhxazZHdFkycXA5UDlIU0NINm5EVEoyQVhsZnlyQUJvTUswWTdB?=
 =?utf-8?B?TGVXS2VlaHVFZ00yMUx4aTJhTWFBa0lhZS9CaHJGSitqR0tZYUk4bE1FR2Qy?=
 =?utf-8?B?a0NzY2pNY3pvVVlqWkxSV1VrczFBTis5WWplZEJDYW5kWTRHb2t5RzJ1eG5I?=
 =?utf-8?B?Qk8zU2RPQkFYb0J2R2RqVmtSTUMvamIwcWlIWnB1aHMyQTEzNElQTmtwLzVh?=
 =?utf-8?B?VHNXN002cXBSTm0veVlLV09iSUxHYWJCeEJLa2t5KzZzK2s5RHdlcjNlaFU2?=
 =?utf-8?B?dkZ3T1dsQ2daVGdpdUVxUjNxSXQzWG1VVENXVElyN0RZZFIxUnN1QlVqenFz?=
 =?utf-8?B?Y2xPLytnTEZrRE55V2psUWM2NzVyeTZZbXhHQUYwakRzVEkrK1FsZUUzUFVp?=
 =?utf-8?B?bkw1aitiU2xOYW9Ma1BSNlltendvT1pzZktpbm15bDAxNjBESXNHLzU1ZU9J?=
 =?utf-8?B?NnRrcGNicCtZY2lOa0IzU2ZDeHlocUh6TkxoakFPczMrYzJFQUxnUkFlbnMr?=
 =?utf-8?B?NlhGaGlqQ08rQ0hCbHViVk85ZGwyRnJ3MTRBWjlxWTlNSDBheGdQYXpGUTNR?=
 =?utf-8?B?b1I2N3YrT3JiK1BhL0IyVzA0RGtXU3N6WDBrQ2VuTjkvcjNLSmZLR3Y0MTB0?=
 =?utf-8?B?cjVzQk9CZUpuaGFkeFc5SFV0N3c1bGNpcEhkekFBMENwcHVFVWtuTWlWcUsz?=
 =?utf-8?B?bWxDS2RnektKUGlqbGFlRnNkZDFWckRQWUxQbFRNSkJZL2pZWjlGUVhLb2pV?=
 =?utf-8?B?eTRPQ2lWcWxDSytkNEtaQysreHJUZFZ5MnRneVpMczBvLzZiVGt3ODBzTHpX?=
 =?utf-8?B?U1dNNnVZNXg3akJ4UjZyM0dDbHhDbytWMi9sbFk4M203cE5GcHhnRjBQRkNU?=
 =?utf-8?B?dzRPUTkyK2J0MSs0R0dkalJzZm9PL1V0YTI2MG80bGp2NjhTZnJHNHpCV0pX?=
 =?utf-8?B?bUJMaStvN0VkMHBXOUZVR21LN3Z1bTBTRi9NVDk3b3hYSXZVb2FQTEFra1h1?=
 =?utf-8?B?d0Nlc0xKQk0xcjBWMzgzdWN5ZytLbjY1aVVlRmhQWWJlTFVTRUFhNWVEMnJG?=
 =?utf-8?B?MTZmZDNJN0wydUlXQWhoWEtIUThpSEYyZmhZVXIwRWZKZ09RTDhEL1VVWWVX?=
 =?utf-8?B?cmVkNmFFU3NKNGdudTB6TUM0QXVwU1dObVZiRUZ1b21YMjJtTGRoNVdocERB?=
 =?utf-8?B?aE1lSmZ6OS9mUUZnaldLMXY0YVZONEk2Ui9XY3pibDZ1ZndvdTd1TUVsUklh?=
 =?utf-8?B?bHFlczR1cDhKTmNyOXUvWTdiQVFxWUZSQzcvUHRkRGdUeFFqRjF4c0tMeUoz?=
 =?utf-8?B?WWxaQ3RieDhFaEZCaDA1c1p5TGxaTWJpc09OM0dhS0c1c3NoRUVDVG4rRkc5?=
 =?utf-8?B?YVg1dGYwTGw3ajA0WXhPODhsUUtSMDVJczByUGRYT0dxV3NhTUFNV0p3SGc3?=
 =?utf-8?B?bjdYVjc0eWk3ejVhQjdab1U3SGkza1lFTjRtcCs1Q04vaVJMVEZiTDEzNGVs?=
 =?utf-8?B?V2lGODJJdVoyMjNnOWs2Q1VkMlhqb1IwZU92dW5mT2dwVGNLQnFrcC8xRlNo?=
 =?utf-8?B?eWRKblc3QjRQWVpwMW1YeHVGcmorTUpSS3U4VExFMnI0WUdna2VWTzJ5M1cr?=
 =?utf-8?B?OXRmbDNPS05JczRQZndneElDMlE5WHNuQUwybkxIeHMxYzNER05POVRvbUtm?=
 =?utf-8?B?UUg0cGdmL2dlU1A2QTlhUjF4bkRZdGh4dzZGeGpWRDJTakZZR0VpWDdYWkYw?=
 =?utf-8?B?cndzZG41cDJWeno0MFZYUmppeWgySnlJY2toU1FVdk9mYURUSXNaQkcxaTlG?=
 =?utf-8?B?TlUvNjQ0UDRhSWFrWGo4dkJNWmgwV1F4eXlPQWMxMEpJVkREcUdOTXlJeE9q?=
 =?utf-8?B?TjNNQnNqZzVmOHgweXFFck5OaDhXUUYzdEU1d21FR05BbVA3UXN1c2U0T3M1?=
 =?utf-8?B?M1UrMnMzLzdwZzZNNWkzOTRvaDJ1RytKd2IwM2hhNTU3R3JIQkF0VFhqS2dx?=
 =?utf-8?B?N25GSWhnenBJcFdrTkhOSlQvOUxpNGV4bnhyTktxNjlObUd3elBkMHRpMnVp?=
 =?utf-8?B?dTBWMkt2RDBDZ2tLOFB5UERzQnBwU3FhbzduOFhjdnhySkdydjZqUkJIUW5P?=
 =?utf-8?Q?27SYL+ioSU5d08P27NiARyc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5456b57a-7abd-4088-0a3c-08da658087b5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 10:06:33.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpscKGLqHxnYyR51tIWN7G6ug3I9LiD3OFMUjqWmsAN1pW4KvfVr6FFIWOb0LcnppwsAkbQai/nBDWkw9n0R6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_08:2022-07-13,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140042
X-Proofpoint-GUID: RCtl427QkR_hUJxstfu3T9Su6YQrKonI
X-Proofpoint-ORIG-GUID: RCtl427QkR_hUJxstfu3T9Su6YQrKonI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/07/2022 19:40, Andrii Nakryiko wrote:
> On Mon, Jul 11, 2022 at 2:45 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Mon, Jul 11, 2022 at 11:13:17PM +0200, Fedor Tokarev wrote:
>>> vsnprintf returns the number of characters which would have been written if
>>> enough space had been available, excluding the terminating null byte. Thus,
>>> the return value of 'len_left' means that the last character has been
>>> dropped.
>>
>> should we have test for this in progs/test_snprintf.c ?
> 
> It might be too annoying to set up such test, and given the fix is
> pretty trivial IMO it's ok without extra test. But cc Alan for ack.
> Alan, please take a look as well.
> 

I can follow up with a test, it should be okay I think (we can use
the "don't show types" flag and tryp to print "10" with a 2-byte len or
similar).

In terms of the fix, it looks good, but given that the code is tricky, 
it might be good to expand a bit on the explanation. Something like the below?

"When using btf_type_snprintf_show(), the user passes in a "len" value, and
we use it to initialize ssnprintf.len_left, indicating how much space
remains for the string representation, including the null byte, so "len - 1" 
bytes are actually available for the actual string data, leaving one for 
the terminating null byte.

In btf_snprintf_show() - which is passed the ssnprintf data as an argument -
vsnprintf() returns the len that would have been written, and this _excludes_ 
the null terminator. But we want to handle cases where the length of the string
to be written (excluding the null terminator) exactly matches the original len 
value we passed in (len == len_left) in the same way was we do other
overflow cases (len > len_left)."

Acked-by: Alan Maguire <alan.maguire@oracle.com>

>>
>> jirka
>>
>>>
>>> Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
>>> ---
>>>  kernel/bpf/btf.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index eb12d4f705cc..a9c1c98017d4 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -6519,7 +6519,7 @@ static void btf_snprintf_show(struct btf_show *show, const char *fmt,
>>>       if (len < 0) {
>>>               ssnprintf->len_left = 0;
>>>               ssnprintf->len = len;
>>> -     } else if (len > ssnprintf->len_left) {
>>> +     } else if (len >= ssnprintf->len_left) {
>>>               /* no space, drive on to get length we would have written */
>>>               ssnprintf->len_left = 0;
>>>               ssnprintf->len += len;
>>> --
>>> 2.25.1
>>>
