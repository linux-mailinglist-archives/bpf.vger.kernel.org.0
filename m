Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0B651ECA
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 11:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiLTK05 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 05:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLTK0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 05:26:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A03BD69
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 02:26:52 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK6YSJp021057;
        Tue, 20 Dec 2022 10:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mYxrWMJDua6+Zz0WC45OLNt4IwiS5e7hGn9Vcst0680=;
 b=QaoBbEDXLfVCjiBB2TeHBn7EB3HYfZwZG4Z8IH1NNHKPywBJSi9n9bzN7TMe9lca90zV
 jyOhEBxxV/b9Xx0IwobUJD047v/wE5lpc9Ftm5mG6f9c0h6zGB4BxW4koK4Dy2PkUFq0
 Vx1KqzAxO7zszJwKSIBasFC4O9Xz/o69UrYTTLc6iIzZ0Qht1WYdAVJ/Kt7EkmpGnlbr
 9f+yd4ZD+FTvl3bGMXA2JriJo+enjNLayDN9kVBQ+awQjEjMDfqje/8uFXOKn3Wstwpp
 skKo/s/UUF9k7Fss3cgIN+4NCM39t9JW8BYAw0uKqAr3EMIz6RzzPPWZdRradksgD2qA Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmwc0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 10:26:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BKAKCcn003446;
        Tue, 20 Dec 2022 10:26:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh474vpn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 10:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVzg5LF4ZF5rj6lW32VvBAqR91+WRgU1JderRJeN//4rQd/Yfyn6RTVWjS6hplzRQlStSrGAq+pld0KFcBD64fFXDqmY1ukXqEWTJ11Dpp3RwiHEx4MTHmZW1y2avehEg7J1rm1rS8fbYIB/USN7DqXEQ/RCXG0ea22z13WSpTrynPxrHjOFg7Wq+BC5i0rR8SiiCBSoGrdsRuJ2J0Q8Xg63D0LVj4S0iIRd/xVqcBo2o3fKIbAUbU6JbEy6ksMW5Hdy/TZHfFjBMPlK6Cid4LOznQjpky5niORqwMy+DMYx2wOanLeWdOc+7smvrDOeBuZsX6VqQmwkRkQyRlFf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYxrWMJDua6+Zz0WC45OLNt4IwiS5e7hGn9Vcst0680=;
 b=OVh2GR4m2PIUbxm8m731c0rR9A6Ch39UBoGpnerv6bNr8XEDQrKhNpB2Qk+JehKJguGQM/fEEZaqsUxHoAOaWl8EW3Ao1RrMjWF+oJ2w0yE0wLOqBAe64MwAhWOYF1TaKvxCwNnG+V9ASY22KmugAegykoRKMcDaJZ6LOEu/zH5VHlDf93rdmAegEBfObVl1rzdFIT0Tdm9MSkWSN9gmUrqxPMyqxo5vesraZJDZMUZtn6IZiKTUq31wTdgzurFm/at08ART5UPdrd3b71lEV4onrWRQWrwzUP//zsnGTEjBlUpHUhaabv5qyDhckBKuU+ya002hIj76XPUS/0Wa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYxrWMJDua6+Zz0WC45OLNt4IwiS5e7hGn9Vcst0680=;
 b=v/AE/cOKySzxdihFuvz60E0mbBBsZDMmH3qbkmZWQSYPalwqVPbojk5PGzAcit2Ikl2LCoWXMjIfpaejBDH8XeRWXUVjmd4IfX/2zzR/i6J1RgO4+r8zuUe8L4xlOff3PlHMMNwXACpJHi0clSH3Go1COmf5Uz2vhNcR+OaAdUc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6270.namprd10.prod.outlook.com (2603:10b6:8:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 10:26:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::f496:5c7f:de65:f4ee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::f496:5c7f:de65:f4ee%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 10:26:45 +0000
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <d979c6ab-7afc-3c83-c7e6-27bad47c0a9c@oracle.com>
Date:   Tue, 20 Dec 2022 10:26:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b97e4a7-6f21-4f50-7a29-08dae274b1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ua63xqZZ2vrv57Z026jrxYhzwScCVOBcEfDVY8xuLG+0vpHLsYo7eFabhhCJx5zepblRtCcSz4ZKvFbVkhBNTZ3SelG8fDoGWSn5Cf16mAewhTX8ZYqdJop0Z3yZlSPGyoTJHoJ3TBrzuW8Tau4k25iIUtM5koTHVLHqdY9twae4GS3tAq/p7iYm+bgqi31edAzmngKY/An4f+6ze2lpJCymqObbdpZxm5d2pCfXfTFxzZFLeqrmKpdwKC/VZB4JBy+LAXtraSv266PDNbeo4Xf4BUY635C0OflxJjLZge+BockFguhCpfJxE0boYdgrq02z4eOEA38RvtxTFX8epvSh9QoanOnsP9INKDCnIFVwynx+P4S5+ZqJsQU962h5XnyQBZ8DBCFEUtZCqX/asWdwR5Y+NAi6M+W9+S7t4o0mWLV5vmBiS15V0pwoEYs2oxUHtvzuVznmj6qCXfSnJfqUeUHNAyGonhGHLPu/90gmhG1VfMJ0/I0aRBvohJI/169VC9XTCUIa/jSX7w0JHi0F9/QE3eOOuBB6Lo8X2U+sXDzDUJNTNkUcpnPhe/0D9qhjBggUNwt/QR3ZUFAXGulFuN4xYnvOXka1NOyzi7w1mYUhbTxnNP6Hn4JBf21ElpV3WyaGptJ9IilE+dewlqOwsDmglj5XxGytZNVNfdnFl30XbjEfxLDTXB6f/0KUBL8rPpFhgPt1Dr1i4LMysHsKE/8jXSjZpZ/cXhS9Ugs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199015)(83380400001)(2616005)(38100700002)(6666004)(36756003)(186003)(6512007)(6486002)(53546011)(478600001)(6506007)(4326008)(5660300002)(66476007)(8676002)(41300700001)(31686004)(66556008)(8936002)(316002)(86362001)(2906002)(44832011)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U28rYkZ2b0wrUXJtekR2WEJHNVNCVm5aSnZya2tPYzVlS0xHdE0zUHg3cHFz?=
 =?utf-8?B?MVpXMklOWGF5WkZucnpqb0IxK3orMFRsWllqT2Q1MDVMRklVM1JnR0x4eXVt?=
 =?utf-8?B?b2dSTkh6QXF1ZEpuclViLzZDaEhVSWxUZzdvazZpQktlSmNtTHA0YkhFWmxr?=
 =?utf-8?B?RDFHZThDdW5FOGFFRlVmUTBXenZmTGYrT1ZUWUdLMXMwTG93UmMyYnBLUGpj?=
 =?utf-8?B?VGhaL1NiZ2VjNnNXeUhOWGhsQlV3YlpsYlJpMEJoSkR4eGJONnc2TFdDdFdE?=
 =?utf-8?B?TW9QVlcwN1lKN21iMUpNdnJCVndCOUJ4VVhZTmtJbGZ5SzdHM1NETkpuS0w2?=
 =?utf-8?B?MDFzU1VFZ1ZlQlpubGdPQ2o5SzN5WkdyQk5tNjBPOC9vWmhha1RwS0RpYXB5?=
 =?utf-8?B?UGkrRnA2citrWUxXZFF6QktTZTJXQWFUUzEwMERndis1TW9xN3A1V0hqYmtl?=
 =?utf-8?B?bE56YjFLR0hIRzBPVHVvWnltS2gveWpveHVzSzNUc2NBbWRmRDNkWWdxYU1N?=
 =?utf-8?B?NXE0dTF6akNacGZUelQwU0NZRFlVbGNzakJUWXJrZDY5T0xkZ3ZCanZmOEJ3?=
 =?utf-8?B?clRDcjRSY3lFRGFqRWVUVU1CRG1WUEY1bklvUXVkcnIvVlRFWng2UFJ0QUcw?=
 =?utf-8?B?U2NQdDNtYmd5TTZRMmtPQ3QzSGs0dEZXYTQrSXJOYUJMcVlydVpKTVdTcFN0?=
 =?utf-8?B?TUh0Yng1WStxMStlbUpkK05ieVVmaDRiTFUxVzhJUlhOZFUxOThjMjNKMnpj?=
 =?utf-8?B?SjNIRytDV3FvK0pIbDltNzNVZkNidFM5Q2tueWNlOERROGdDNVlOK3JnQnhG?=
 =?utf-8?B?Y2dhdGdpbUcxdldKM3lLRm1xb0pTK0FNTHFwODJnT24vajc2eHRUbUh1Ylpq?=
 =?utf-8?B?OVU1Vy90MFVubDdiQ1pkZDNrV3d4VE1oSXh5WkFlZ283YjdtdUd1dWRZU2FQ?=
 =?utf-8?B?ZERzVTZpMHZYTDRTYUREVmJSdUIzUUVISEQwNGFvYUlxTzg3eWZ4dWpuWTVJ?=
 =?utf-8?B?OHBXL0lIdityY0MwSklaVXd3emVpcHZkUkk5MVRCZktYdEhCYXNTZlVpRVFE?=
 =?utf-8?B?S1FpaUluejBPcVFPMDlheCtwZUpUblptcDYwZU9tdzhLamlXZUdEVnk3K2Vj?=
 =?utf-8?B?TG5qNUZzUEJDSklhb1Y2NnZEcWNGdXhwRzYwbitKb01Ta2t6Z1gvb3NxMWhD?=
 =?utf-8?B?Qk05d2lzMnBHTk5zUFJpb2djcG5XUU85QVdqenBCTHlxcmdld2svUXNOaTAy?=
 =?utf-8?B?QTlBR1JJQXcxMHNRNEhsWGs3cHFqa3ZRZmxlb1BnZWFqdnkyS3FndWRZUXVB?=
 =?utf-8?B?NHlhYmh2VVM3U25scjVNTzJpK29Qdkd0VFhYeEdjSkVVRk9sdU1QYW55SGo2?=
 =?utf-8?B?TXpHLzhHQW5HdjV3VG4vcUZJS25ya1h4ZEg2d1ZDNGpFSTFGUllnTENYeFJU?=
 =?utf-8?B?U1NocG9vakMveXMwaHV3cG5sZ1kwK0RYVXJBVzQyQXVBaUJOK05Kc3EyRms3?=
 =?utf-8?B?RmRmd0hIWXpQeEJFSjZHZVZDeWNDaWJqTEpOTDFTVUo2NmwxQWYrTzlBeW5M?=
 =?utf-8?B?bTgwSzRqb0JUZ3JsVjd0UitqS2dBZmtadjVlZWZvUWdzdmFUckxvb3lQNHQx?=
 =?utf-8?B?dUhwQXBIZ25RaW9Uc2lEdGJNRkdpTTRZT2JKUTBCdHdHbzM1MzZnWnZHd0Qw?=
 =?utf-8?B?NmExc1ZXQzQ1WDA1S1ZQUHhMNUVNSVFzYWZWQnlCU3k3TVRIcVkrUndJSWZI?=
 =?utf-8?B?SXA3ZUxhTlJtazZ4djJGVTE5amlpRDZtRWdvWmpOMS9kL2xyL01FK1Nlckxy?=
 =?utf-8?B?Qkd0SGFldXdXWWI4WGhMR0NrTUZkT1lFbVJXNStzM2x3ODI1d3A0TFp5U2lP?=
 =?utf-8?B?azZlQkZnaG1vUHE1bkt5R0FucE9PaitWR2l4YVNrWjkzTjJqVjBRKzhJbCtG?=
 =?utf-8?B?azFXZTVjUXhkd29tc0dyN2pEWlBnWDIxL2FHOWZ4SjR6MG9iV0QzdXU5T2ht?=
 =?utf-8?B?dDR0c0JNMW9vV01XS1U3QUh0Y3RkWThET1VlcVhaZjhQQ2NmQ0MrdDc5Rno1?=
 =?utf-8?B?Q3FJejNPSXpwQURkelpKeEJ6UTRid2NCc2F4TWx4Y3JBUUlQMmxOTXI4T3Bw?=
 =?utf-8?B?cTFneFF2a0g3L1ViMHNkOWN5SGJQQ0pSN0hiV1U5UWJrNnVlclBTMDAwK3k0?=
 =?utf-8?Q?vM8XeaOpgzlJJ0BFyABXxMg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b97e4a7-6f21-4f50-7a29-08dae274b1af
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 10:26:45.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raC6EjbGxZVfcUk7lsD+VKEGC+lGJvH0oqdR5EDCGMinEEazIjv8+DZqbz1k2bpeHAZRu+q+Y7+kB4kdGlixkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_03,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200087
X-Proofpoint-ORIG-GUID: LChTSu1w-Jr319BUagoMS4m7SLG4-gWS
X-Proofpoint-GUID: LChTSu1w-Jr319BUagoMS4m7SLG4-gWS
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 17/12/2022 01:57, Aditi Ghag wrote:
> The socket destroy helper is used to
> forcefully terminate sockets from certain
> BPF contexts. We plan to use the capability
> in Cilium to force client sockets to reconnect
> when their remote load-balancing backends are
> deleted. The other use case is on-the-fly
> policy enforcement where existing socket
> connections prevented by policies need to
> be terminated.
> 
> The helper is currently exposed to iterator
> type BPF programs where users can filter,
> and terminate a set of sockets.
> 
> Sockets are destroyed asynchronously using
> the work queue infrastructure. This allows
> for current the locking semantics within
> socket destroy handlers, as BPF iterators
> invoking the helper acquire *sock* locks.
> This also allows the helper to be invoked
> from non-sleepable contexts.
> The other approach to skip acquiring locks
> by passing an argument to the `diag_destroy`
> handler didn't work out well for UDP, as
> the UDP abort function internally invokes
> another function that ends up acquiring
> *sock* lock.
> While there are sleepable BPF iterators,
> these are limited to only certain map types.
> Furthermore, it's limiting in the sense that
> it wouldn't allow us to extend the helper
> to other non-sleepable BPF programs.
> 
> The work queue infrastructure processes work
> items from per-cpu structures. As the sock
> destroy work items are executed asynchronously,
> we need to ref count sockets before they are
> added to the work queue. The 'work_pending'
> check prevents duplicate ref counting of sockets
> in case users invoke the destroy helper for a
> socket multiple times. The `{READ,WRITE}_ONCE`
> macros ensure that the socket pointer stored
> in a work queue item isn't clobbered while
> the item is being processed. As BPF programs
> are non-preemptible, we can expect that once
> a socket is ref counted, no other socket can
> sneak in before the ref counted socket is
> added to the work queue for asynchronous destroy.
> Finally, users are expected to retry when the
> helper fails to queue a work item for a socket
> to be destroyed in case there is another destroy
> operation is in progress.
> 
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 17 +++++++++
>  kernel/bpf/core.c              |  1 +
>  kernel/trace/bpf_trace.c       |  2 +
>  net/core/filter.c              | 70 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 17 +++++++++
>  6 files changed, 108 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3de24cfb7a3d..60eaa05dfab3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2676,6 +2676,7 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_sock_destroy_proto;
>  
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 464ca3f01fe7..789ac7c59fdf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5484,6 +5484,22 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * int bpf_sock_destroy(struct sock *sk)
> + *	Description
> + *		Destroy the given socket with **ECONNABORTED** error code.
> + *
> + *		*sk* must be a non-**NULL** pointer to a socket.
> + *
> + *	Return
> + *		The socket is destroyed asynchronosuly, so 0 return value may
> + *		not suggest indicate that the socket was successfully destroyed.
> + *
> + *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, **EINVAL**.
> + *
> + *		**-EPROTONOSUPPORT** if protocol specific destroy handler is not implemented.
> + *
> + *		**-EBUSY** if another socket destroy operation is in progress.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -5698,6 +5714,7 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(sock_destroy, 212, ##ctx)			\
>  	/* */
>  
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7f98dec6e90f..c59bef9805e5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2651,6 +2651,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto __weak;
>  const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
>  const struct bpf_func_proto bpf_set_retval_proto __weak;
>  const struct bpf_func_proto bpf_get_retval_proto __weak;
> +const struct bpf_func_proto bpf_sock_destroy_proto __weak;
>  
>  const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
>  {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..016dbee6b5e4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1930,6 +1930,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_get_socket_ptr_cookie_proto;
>  	case BPF_FUNC_xdp_get_buff_len:
>  		return &bpf_xdp_get_buff_len_trace_proto;
> +	case BPF_FUNC_sock_destroy:
> +		return &bpf_sock_destroy_proto;
>  #endif
>  	case BPF_FUNC_seq_printf:
>  		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 929358677183..9753606ecc26 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11569,6 +11569,8 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>  		break;
>  	case BPF_FUNC_ktime_get_coarse_ns:
>  		return &bpf_ktime_get_coarse_ns_proto;
> +	case BPF_FUNC_sock_destroy:
> +		return &bpf_sock_destroy_proto;
>  	default:
This is a really neat feature! One question though; above it seems to
suggest that the helper is only exposed to BPF iterators, but by
adding it to bpf_sk_base_func_proto() won't it be available to
other BPF programs like sock_addr, sk_filter etc? If I've got that
right, we'd definitely want to exclude potentially unprivileged
programs from having access to this helper. And to be clear, I'd
definitely see value in having it accessible to other BPF program
types too like sockops if possible, but just wanted to check. 

>  		return bpf_base_func_proto(func_id);
>  	}
> @@ -11578,3 +11580,71 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>  
>  	return func;
>  }
> +
> +struct sock_destroy_work {
> +	struct sock *sk;
> +	struct work_struct destroy;
> +};
> +
> +static DEFINE_PER_CPU(struct sock_destroy_work, sock_destroy_workqueue);
> +
> +static void bpf_sock_destroy_fn(struct work_struct *work)
> +{
> +	struct sock_destroy_work *sd_work = container_of(work,
> +			struct sock_destroy_work, destroy);
> +	struct sock *sk = READ_ONCE(sd_work->sk);
> +
> +	sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +	sock_put(sk);
> +}
> +
> +static int __init bpf_sock_destroy_workqueue_init(void)
> +{
> +	int cpu;
> +	struct sock_destroy_work *work;
> +
> +	for_each_possible_cpu(cpu) {
> +		work = per_cpu_ptr(&sock_destroy_workqueue, cpu);
> +		INIT_WORK(&work->destroy, bpf_sock_destroy_fn);
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall(bpf_sock_destroy_workqueue_init);
> +
> +BPF_CALL_1(bpf_sock_destroy, struct sock *, sk)
> +{
> +	struct sock_destroy_work *sd_work;
> +
> +	if (!sk->sk_prot->diag_destroy)

risk of a NULL sk here?

Thanks!

Alan
