Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653046F5F33
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 21:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjECTfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 15:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECTfm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 15:35:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0DF65A5
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 12:35:39 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343FYDSb001804;
        Wed, 3 May 2023 12:35:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date : to
 : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=ow7U3Co1BUIdNQaK/zILxTs9mGj3RS96VdyTp7c4C1U=;
 b=EOAC4E9PM6ucwDIRosDrUJBa49gfhTTwYxIByztrrriJCQd6C/Sow4DNu13y1erwN5sN
 ksXUAHzpQ4HzLnaSY2p9JKkeehK93axw7fml0mgQxKLlyhgaDteeqp2NsaXWgqUDz9Nh
 Kizn9j+KXZ6V7U0mSr2m07OUtVpxciulMMNaAcpxRWXc4v03Wk/aIvl5wy5mGCZFOQy5
 2k4RtHGVgqBBxqVuXtgtmhsQ18m4s9uStPxXQsCwzLRRd0krIZB+ESWI0HXXesbjRnp2
 ryCKt26NpSyptEuP1PANcfdQs0wgtAVfNP7Lb3V3EZOAfQE+IuZ5oi/z61HyBQU+LmLt nQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qbhx255jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 12:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUyCwFfufa7WDRBDhFDfpokP7jeGHM6wo6opZ2vGOHNxkLX1657NBHnKBZh3g2P24FMhcDc71opCIXRFHId0LWBg0qViu1TvFZBJ7vAUJtRFGCOhmf35q/DEuhvSZDcxwWhPpdQRukSheoddTEweeXGjxXhFvHHWH6adpGSkQinO4in16GxZRepLSP739JxmViIC1N79BGX5mLqcD5iySAVaJnD8nF7paslv9PcqZnB/QIPlWTqUKxD2wGuXbz6BCwlsY+i9f47z3jNhM6vNSFE3u5+weKcPQfXH4eUE1l5gf1lSbgfM/zqOOijmswt8BvMR6p+Rg4QKnilg+9oTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow7U3Co1BUIdNQaK/zILxTs9mGj3RS96VdyTp7c4C1U=;
 b=FVrIQWJivOmnbQl4B38dvxAdinYinJM0Tjvzbeqhbflv+JhIfLoqU9WEbxpUmKmTSjvWodhd9f56nK9u+G6Uykz+tIKnLAUkwpTqQ/fvSc/8oqT2FjGRTKehhFbWuX1XzwPXycUmR3XFxsWXWtGL0Vw2SB7bOkP8fYtdEhfrQ3daX4OKukSDHD3MKRUSGPZ8NzbbTi+7ZHpTZVsZz087D8a5/n7uxnU997PDzj/YjKRHGEy4bLtVQI+GttP4TJ/DTNpw/w0p6KsigEiV+eNLXDYRHNGSChFfwAJbvXHNRWi2NcFZRBQhB58hRooKUqsDZvtZdGwT1Es3/DKasX/uEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4372.namprd15.prod.outlook.com (2603:10b6:806:193::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 19:35:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 19:35:35 +0000
Message-ID: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
Date:   Wed, 3 May 2023 12:35:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu Bretelle <chantr4@gmail.com>
From:   Yonghong Song <yhs@meta.com>
Subject: selftest sock_fields failed on s390x with latest llvm17
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8e7805-b9dd-44f1-fdbb-08db4c0d9135
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OX5BX/P83Kc7RTANkAfRsF72uDSg/6lO05gofC4CYPwoSiiYeb7iCvT1ofC/DGMQd2cMH/5IX3cEgXP32s7BTaXDGyFSFbc9xbzdQR6taabcWqXFXLh6SWm1K8D4N8JNY0Sb0m2LNDiPMfUSzbEM+tskEJu9vmsQ7/YMNba/Oq+ytG87GXMEfGQ9gMc4DhR72BX84BAPHjAWB39er34dXaBwbGxa0SRpWalzXzcthR4t2dhX2IJgPemklNRhCT39wxXhyQvgQmadKBMFdHXglcx2IuqWtYOhfSL+is02DYJUpT8OebZDTpmkp7Ur3ZuXvKFfpIQy7bVQGtGdsvP5U2vaHD9HcW3fPpW0vJkJ01p8HjX8COEG6GGQ7+Y8hH6DpBhD27lUIQ4cWA9gwue02NpajCLmU/DoZ1HaiMUQADhI23DwqiK7WzFOoMLJvm1fM7CiNMu3f4q+Oom07xlDzFa8eS4GOII3bzY8c1W0YVtJR2r5m61uMIpdtkuK401++q+JHX6E3L4e8E1mD8jOnE7Xvz3RPcnzjNoVzsH8ej08cgN0DECb/ffuGxCWjKSxbSIauOWZlk/MMo/NrChQFpm7Yu3PsRzzdzxqtrn+30B7SQ5BlBByIyuh+Gh6PGYh4ozNaibfEbwqyYDl27mdKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(6486002)(186003)(83380400001)(2906002)(6506007)(6512007)(966005)(54906003)(36756003)(2616005)(31686004)(478600001)(8676002)(41300700001)(66556008)(38100700002)(316002)(66946007)(8936002)(5660300002)(86362001)(4326008)(6916009)(66476007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3dhcTVWNWllNnZKdDJQWWlLWEJkWWcyNFpmSllsejVqM2hML1RYS0hpVG03?=
 =?utf-8?B?TkgzYXh3a3hEZUh6eDlIMk5Nb0lLa05XWGplaE9tK05CR1ZmaFp4Q2R0S2pE?=
 =?utf-8?B?UzNxMldFVFRYdXprOHZ1cnE5ZTFsZEdDYTczdlV5b0xUcHM4MnFSZHRXNUla?=
 =?utf-8?B?Y3l1cW9jSXB2Vk1HM3E1cTF6Sm9XbzFIK2RIdG9qdWZ0NStPbVMyVHRWY296?=
 =?utf-8?B?MzhPUmh5Vk9jc3FUQ1hCRmlGUEFkUk5RYndPVWMwMFU0YVVmV0NHMHRBcGJB?=
 =?utf-8?B?dTBkQWdUeTBuZkRQT2c1UFBmQ3V2aEg5bWVOdFhNdERGajE1elJkc1I2VmlD?=
 =?utf-8?B?SkFLZitPNjVTaDk0WExVR001cVR1dGJoc1lQeFRVcExna2M3YXhUNHNBb2Zs?=
 =?utf-8?B?ZDZ0UzE1UmNjZkV2MU0xNWpUcUQzenA2UmtvUHpYNXNUM2VlRzZENDNsUUds?=
 =?utf-8?B?TXBwWGtqbDhIcDVvWGs4azgzQU1QaW1lMjZRdGNsbzEyNWdrbVNsc3dLQmJu?=
 =?utf-8?B?NERaQmx0S3dnQUg2RzNNaFBMWXRid0Q1Skw5UlJBVlhRbmIyVk4yc1FwbjFL?=
 =?utf-8?B?eEE5eUhmTzJKcWJBWmxFU2VnKzJsaEllWTNZNW9rT2hoUklwZGd1K05SSCt1?=
 =?utf-8?B?cXhEOUFaZDcwSUlmSWhSamxnb2pEb2NXa1d1bThwQWRZMExyLzJYS2dWK25u?=
 =?utf-8?B?Z09ra1R3VmRYWUJjdDNTNGFTSkNudlpFazFrS1ZwRlp1blNoSkVHNitTSVlp?=
 =?utf-8?B?dUhEMEloWG1lRStJMk04eG42ZGJobjBlNnJBWTR0OFAwVXNZSUxRcDZMSzFq?=
 =?utf-8?B?cnZWZ21yWE9ZMEE5S3VWdHUzcE9OcE1lY3lKRU5wOWpRQXdpcGo4SWxVdkl2?=
 =?utf-8?B?N0RESnVFbTNZQzNBckJXdlhPNmRvY2NBaE43UTZ2cSs3Qk85K3JlSS9JUFV0?=
 =?utf-8?B?RkNuVG4zVnQrMXdDd3VNa042RWVJY0orZVBQeU5ETjBDbXpZQzVrbHQremtw?=
 =?utf-8?B?cXkrUmZBb3BmanpLbEF3Q0p2dTd2UGtTbmRGY3ZGRGp0MW5FbXZWOGp6L2ZI?=
 =?utf-8?B?dUZhTXNtZjU4SEhaNUJpdmlDKzRYb3dPUDd1dFRaalp1VlE5cXlTU1NQLzBT?=
 =?utf-8?B?czQyMFQ3dGJiS3pBS0QrZkQ4eCtwYy9DeE9UTmtPdFhqcUM2T0VTaEl4aUlk?=
 =?utf-8?B?ZER5V3ViK0JkSW5ocG9obTBoZ0V0N2ZMdStSQXlkS2MzUThKKzdnMXh2NmJm?=
 =?utf-8?B?YWVhT3VRVmc2OTRqYU9SMVpHd0YrbUVoY2VDa3lEZWR3cTNZc3RRcXFJUEE0?=
 =?utf-8?B?a1FzLzJWVDFxL2tyODcxbUZxS0k0eFdOeTgvWkJIdFRYMnlMcDRIb2U4TGUv?=
 =?utf-8?B?V3oxVFBFZTIzTmYzUjcxSTRzNkozN2t2WWduQ2N4TnhIY2dZcUpjVTBmWWF3?=
 =?utf-8?B?dWFYU0VoZjlHQzVjK1R0Q1pPaWhTWWM4QXNjU0ladHZRNTg1elNWR1kzekFW?=
 =?utf-8?B?dGU0b2ZPSmJ2NkkxcENGTEJHMEFHWXBtK3p5SGJueFA0OGlGMExjMUFLWGhn?=
 =?utf-8?B?TFVjLzVKV1pxV3pkMVpzMVhFcDNLWUJReW0yMStyUTV1L2lvK3VtTFRYNWxa?=
 =?utf-8?B?eGhkWGNSMXJ1bkFzZjBnZFlVejhRM3UrMC9weUFCZW1EaEJRSnUvb042dTE2?=
 =?utf-8?B?SUJiWkp2ak5VZkFsYnJabjZ6STAyV2RFWEdqd3FydzB1ekJua2lsTVZ0b044?=
 =?utf-8?B?ZVBPdFV6c2pIMU9QWWNOU2hxM1J1L1YvRUF4RnBmbWZaV0Q0QWV4eW1iYUd0?=
 =?utf-8?B?T0hCbXFjaCtoelZudkQ5RDVGN0p2WFRnTE1LQkdtSmVhNENGOFVIdjgwVjNN?=
 =?utf-8?B?eGxNZGRkOWVybCtEK2gzY1lyVHVzNzdvdEk1MDA0ZU9qY2J2dkJmSGhvR1k0?=
 =?utf-8?B?S0tCTkV2SkFaSkpJd3daUW10OXcwK2NLb0tWN1ErOUJSbGF2M0hEOHV0eDdT?=
 =?utf-8?B?TDYwRk1aSmxZOWZuVWl6aUdOc2ZpNkxGa0dLNnhYNWNEWHFrM1BhVTNIQnpx?=
 =?utf-8?B?Q24rR0doS1lDd2o3QUI3clNabURaVjlqQXAvaVVFeHI0K1BScXE2NlVSbGRB?=
 =?utf-8?B?RVhUd3M2SjRtc1NVb0ZoU3NNUmdnWTBhVEk3WHVORkZFY0lDdXFXcExBaFJo?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e7805-b9dd-44f1-fdbb-08db4c0d9135
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 19:35:35.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KE0RfxJ7Y69CN0SjAScKMVNxEYnUgTdJnUAcHsWcdtbFAIU5ZvhRyWxGDDiFuUbY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4372
X-Proofpoint-ORIG-GUID: lwsJijXxtzl9qWewbDFug4SlCAzP0gEd
X-Proofpoint-GUID: lwsJijXxtzl9qWewbDFug4SlCAzP0gEd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Ilya,

BPF CI ([1]) detected a s390x failure when bpf program is compiled with 
latest llvm17 on bpf-next branch. To reproduce the issue, just run 
normal './test_progs -j'. The failure log looks like below:

Notice: Success: 341/3015, Skipped: 29, Failed: 1
Error: #191 sock_fields
   Error: #191 sock_fields
   create_netns:PASS:create netns 0 nsec
   create_netns:PASS:bring up lo 0 nsec
   serial_test_sock_fields:PASS:test_sock_fields__open_and_load 0 nsec
   serial_test_sock_fields:PASS:attach_cgroup(egress_read_sock_fields) 0 
nsec
   serial_test_sock_fields:PASS:attach_cgroup(ingress_read_sock_fields) 
0 nsec
   serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_port 0 nsec
   test:PASS:getsockname(listen_fd) 0 nsec
   test:PASS:getsockname(cli_fd) 0 nsec
   test:PASS:accept(listen_fd) 0 nsec
   init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt_fd) 0 nsec
   init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt10_fd) 0 nsec
   test:PASS:send(accept_fd) 0 nsec
   test:PASS:recv(cli_fd) 0 nsec
   test:PASS:send(accept_fd) 0 nsec
   test:PASS:recv(cli_fd) 0 nsec
   test:PASS:recv(accept_fd) for fin 0 nsec
   test:PASS:recv(cli_fd) for fin 0 nsec
   check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt, 
&accept_fd) 0 nsec
   check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt, 
&cli_fd) 0 nsec
   check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
   check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
   check_result:PASS:bpf_map_lookup_elem(linum_map_fd, 
READ_SK_DST_PORT_IDX) 0 nsec
   check_result:FAIL:failure in read_sk_dst_port on line unexpected 
failure in read_sk_dst_port on line: actual 297 != expected 0
   listen_sk: state:10 bound_dev_if:0 family:10 type:1 protocol:6 mark:0 
priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1) 
src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::) dst_port:0
   srv_sk: state:9 bound_dev_if:0 family:10 type:1 protocol:6 mark:0 
priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1) 
src_port:51966 dst_ip4:7f000006(127.0.0.6) dst_ip6:0:0:0:1(::1) 
dst_port:38030
   cli_sk: state:5 bound_dev_if:0 family:10 type:1 protocol:6 mark:0 
priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1) 
src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1) dst_port:51966
   listen_tp: snd_cwnd:10 srtt_us:0 rtt_min:4294967295 
snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0 mss_cache:536 
ecn_flags:0 rate_delivered:0 rate_interval_us:0 packets_out:0 
retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0 segs_out:0 
data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:0 bytes_acked:0
   srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272 snd_ssthresh:2147483647 
rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810 mss_cache:32768 
ecn_flags:0 rate_delivered:1 rate_interval_us:272 packets_out:0 
retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0 segs_out:3 
data_segs_out:2 lost_out:0 sacked_out:0 bytes_received:1 bytes_acked:22
   cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730 snd_ssthresh:2147483647 
rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715 mss_cache:32768 
ecn_flags:0 rate_delivered:1 rate_interval_us:925 packets_out:0 
retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2 segs_out:6 
data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:23 bytes_acked:2
   check_result:PASS:listen_sk 0 nsec
   check_result:PASS:srv_sk 0 nsec
   check_result:PASS:srv_tp 0 nsec

If bpf program is compiled with llvm16, the test passed according to
a CI run.

I don't have s390x environment to debug this. Could you help debug it?

Thanks!

   [1] 
https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jobs/8679080985?pr=224#step:6:7645
