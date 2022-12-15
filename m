Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC864E0F2
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiLOSeS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 13:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLOSdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 13:33:54 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C04AF25
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 10:32:32 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEGua5013230;
        Thu, 15 Dec 2022 10:32:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Uu5wYwCNSVYcoV4xGyWSQk53em2DVdAD2kkFBGWN+Rk=;
 b=PfosgUleww+Ai+SOsq2yWPYxrSSITKbI31d3139cfOYiFz94gdWwng4Sl0FPKZGwSA9g
 02kcn66u8dXXRZ8dG8sDXm01VLlR6Z8ZQmlFI0uRGPmO3IAuXX82XVpkIXFpdHnDv35C
 XT8p6V6lbMrKKbFGgJZNgCrurJXXzdECx/hEoCypUK6tIZFbD1llYOe/Eob7gLW2Vt5R
 wO2SO9e+hvDpHR9DV21AazBJ3A3AkkviUq/OIKTAtttqotnBLhsOU8j1qf1hTCC/28P5
 L1XGLTSRWW0iAsSRLH+N2hD72iMJjf07Xp0GS4TP9xfLk7vb9PRXjpB98pSBPIdmaKQW Jg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg3hhter7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 10:32:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBUa0my0UDUF0uxCxtcjEWEjc/BUszFtTt/40NolhfzEqG5+FJHO2/UJ5omZGY90P/g3Civs9oJnW73aA7dCKXapfPDYi2frYPEVIWgr3KEZrlTMy6E6yYaC1xTsD3rFXMwMOcaQAaQoPUPjcsbxyrop6P7gkAmC4X4gX82o8n4FYa2N8RZqjREyU40sB1PjzPtqkl+t1GNim+ZLhhcXIt+C8r4b/JpO6pbG+YXulJ7N1LcSN0Bo/LDPY7VMgSpbBNduug7Lxx7wM8X0teDL8lcE2iaK8WfwlHd8Id+YIqVJI35EJ8qEqSTAiS8vHtcHxMR63qw9g0sgbjNteYcmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu5wYwCNSVYcoV4xGyWSQk53em2DVdAD2kkFBGWN+Rk=;
 b=J3HQBQtAVaTgdrFwzp0BIEPbrfpr9Q/Zt8Px1MbCqhDNDn5wU0FMSeMKTXK5N3xvh7nZb3wchtFuTUfBpFHCBKhRTeQGrxXnqtWsdxdEpG+ja6lOypLHgvPNC3PW/FlUZMs32kTKkb4/sH0gPsnGYb2myZ2QrPfJP2Aop8Csi/zZo+5Sv/DD++Tkc6XMvTnAShjIk81wS7Y6AXNe35yB1sXpcjAxBS2LGoLZUhleHm15ZvFpGCY6e9jAii/y0d9GA3werBF/hk/N1Ia289X0hlLhHt3bZExZCqlWUiOD4ZDzpvArIzD4kTx+egZaEgF04HBIyszp7iXBCWDFTYuGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3074.namprd15.prod.outlook.com (2603:10b6:408:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 18:32:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 18:32:26 +0000
Message-ID: <3f12c424-9a1e-0a62-8b77-27a27f6786c0@meta.com>
Date:   Thu, 15 Dec 2022 10:32:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next v2 5/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-6-daan.j.demeyer@gmail.com>
 <70ea5f8b-be37-267e-56d6-381938cb6e5b@meta.com>
 <CAO8sHcmNKN6kagFeCoWzjf1K0sOqTQxfdDG-U8iqBGN=TaHefg@mail.gmail.com>
 <76c8be5a-685d-539c-7323-ab1dc9b06464@meta.com>
 <CAO8sHc=aWEaDiAaPSyquMdH3q-2=szb9WLFAUmQm+jdk5Sp+zA@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAO8sHc=aWEaDiAaPSyquMdH3q-2=szb9WLFAUmQm+jdk5Sp+zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB3074:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dc395a-b4de-4b5a-8e54-08dadecab722
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYT6keZpykSmnyRJPBeylTJRFnJjq1Vrn8j3HHMcAUlNqQcMecO1HEw3yWtyVYrCDFW8i83O1eeD8aa7Ftx9vS0ywSbo3+ys3XlTXjPGdYJ5Luz2sN7WEy3DR0r46EvacTw2fgcfKSPDfxLZzVN1Js7f5i840V9tXo9LZ7U/BpIvaZaiGvlqGXR+hauCc7OKlAKGjRr43Ws0ilTlrWT40uohSMr0ChjDObuVbUiFSOxDpge1wmecXOQrNQnBoj0qTW5egy4ik4f3udg71RW8WwfPww16ULN8qDUpnfiN6T8CVLmYi/9bLdDARXC0ZGRZZHxBVbNHkuje9DuOsrksqtpG/JvKs3bOlklhjjU7Q31fk7DoZyCXEiGDrp1pUye2GlH6hWRq50pgngHk790/VJ0J2+UERtE7LCenq+S0Vd6l+pB65z8MnPstjmHf3lyuUi/qsYXQlsxgZndKfP1THzFCSviGokTPmAXY6vI7GyTy5DfrXDbl2Fwc6AyzWg4x8BS6K4G49H/1ztfkMUGmn/gTNl6Pjh8Yxv13aVVqSYCU3o0TOHne3FQXn1g+6jCdXz8R4rN4PD5c+AyCwIp5pSzOmLimxIRa8iksDNXedg21+9Yw+38wc/dcDaUZgCdK9WyGvLSayW1GgPa5zYq0ZQLQmdon7riTx4HigzWyvb9NDw8iHDiZdResNHf011Lb1WCDSyKUKOPwvPwe/hEKyZW0Ipx2ncvo6zY864flUjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(36756003)(2906002)(8936002)(5660300002)(41300700001)(6916009)(83380400001)(38100700002)(31696002)(86362001)(30864003)(31686004)(478600001)(6486002)(66899015)(6506007)(4326008)(107886003)(53546011)(6666004)(66476007)(316002)(8676002)(66946007)(2616005)(66556008)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFg4OCszQ0tuT1BsQ3lhQzVjL0pNQVkzNVgxM3J1SHRCZ3RuaHE4M2hrcXNv?=
 =?utf-8?B?SThjc2szcktCZWdOblMvWHBMQlhpb1ozL3MxYjN4SGdKWHoxSlpQTTc4UExm?=
 =?utf-8?B?UllSTjVRTTBhdWN1YkI5Z1RDN0RRUEpNUWZ5NW9MWXBtK2VKb3F2MFNSMFow?=
 =?utf-8?B?TEhoWHhKbmIrVCtnY2cxa0R5KzF6cmtrazYvaGtRTk9KeGJ4TFhUdXQvV2ho?=
 =?utf-8?B?eGU0TmY4UWFFaGNjVmEzZGlSZEdpbDUxQ0F2RzdvdEZKeUFEV3pnSzZtOXJO?=
 =?utf-8?B?VHQ5bUFYRmpKNWhtSXRQTlJZYm1EZzIyNUptWUsybndFSjltcTNzMk9SZmd5?=
 =?utf-8?B?aEtEbGtGdW5wN3lQRC83T0hGOWx0VFoyQlJXRDRoVXRCZEtqQXdUTHdUV1Rm?=
 =?utf-8?B?MUtWY2xCYVM4N2dYUmhQOHg0Q3pEeDVBVllreEg3OUoycDhSVWk4WVVQZDFG?=
 =?utf-8?B?QzhmRDRvYTdyWS96RUhJbEZTYWtZQkpNMjlGUC9zb0N4K2RHUTlqeExFRUlW?=
 =?utf-8?B?L1VhbVZ2ckw1MmhqRmlORUpNR0taL2RBT0lqVlBvU3QzZnJhTEV0RitWNzVG?=
 =?utf-8?B?d2FhWnphcTBOb1VXeVFQSVkxejdNTUtLUlNscWR3Wk9LblpSd1NXUFBPeXZj?=
 =?utf-8?B?Qno4TldxSjVTOURzL1JVdVNKQmxNNjVOVUJvZHBuMWJPVndSMlpvUFhZSkVr?=
 =?utf-8?B?NlR5UDI1YjBJVXgxNmN0bnZKd3dZa2ROZXJUNFRPQWlsbTF5MGthQ2p0MGhu?=
 =?utf-8?B?NVJQKzRxdi9STXhoSlhxcUVwVkJpOUFiaGJCYThZdHdaYWoxYTE2RHJWRjk2?=
 =?utf-8?B?S2xkTytPTitHT3VCNmhlcks0dWExdHpVNTdqNHZuUUtSWW96ZE42UmlQY2RN?=
 =?utf-8?B?OHdrMWhWTGZaNkR2aW9OZDA5a3JDWTAvd1YrVVQ2MG5hZnh6S25MV3JhcGhw?=
 =?utf-8?B?ajIyUnc3bDlualdudXJpWTRsc01iSjZvSzIxUUgzandQVUlZTXBSeVpmMG5k?=
 =?utf-8?B?VWpvSXZNWXJ3dzhiSWZSU1hGU1QvRWJEdTBpWDdWcVdpNjc1eDNkYVk1Smtl?=
 =?utf-8?B?a2JXMllTQmYxd1psNGVvZThPM2pORFFBYktEaDJoZGlUOU8wcVFKVWhDLzJB?=
 =?utf-8?B?Ritjb1k5UnVuVzhjUTB0QnUxdGtVM3I3RjJuajE3ckpvMWxCR0dWb1N6OGtt?=
 =?utf-8?B?aFpiTnlub3hycmFiVi9GZFdPOFA4bzB1emtURmtaNmtzb0pnRUtQa2ZPT1cw?=
 =?utf-8?B?QktQSUk3dmZ5VjJNNjk0SzBFMWVsTXBjeWMyRndDWGk3emF0NlR0V1pqOWdS?=
 =?utf-8?B?VS9kS0ZQV2ZCcmNxUExzQ2c4RFpIZndhamt6L3poRHkwMkZMR2ZtNFljTjFF?=
 =?utf-8?B?SlZEUHd3ZGRBM1gvLzBCQi9maTJvMFFzT3pZRmpFZ0JDdGJ1cmZNcTFVOVZX?=
 =?utf-8?B?blAvVzg4VGdCWkg4K2FTWGFKZFZnemhPb3JNc042Y0NmbU1XRUlybEQ4UGZ5?=
 =?utf-8?B?Y3ZwcjZBWVpRcm4yK01PUC9iTVdGR2hhNWlmNDFiMW14S2dmcmxWUVlJTzU3?=
 =?utf-8?B?eFFJSjAwY3V4UnBuWXZJSEplVXIwcnNuSERVa2FTVlpybTRHWWxHNTROWG5u?=
 =?utf-8?B?bWFnNHlsZnY0S1NMSmpQRHE5Y1ByeGYvYTRPNEdSNzVtdVg4clBXOHY4MVI1?=
 =?utf-8?B?SWNrZTBQYWc0TTAvclpTWkJPKzJqaFROd2Q1aU5yTFJOQVI2K1RVbzFMcGVz?=
 =?utf-8?B?dmVLNkdReDFKeFhCWmE3T0pYYVhEY3MyWG1lSFZHSVpSdW5UTkkyZTlQYmha?=
 =?utf-8?B?eTBnclhTVjhGMHFLSVBSSi83WGlpL3RMM1Jnd3hhaVZhUkdrUjgvSEdoWDdW?=
 =?utf-8?B?ZWFVRm1rMi9PbFNFTDdKSTBvWnNIUStQOEVUdXg3dGxQQ1ZYU05palp5RzZw?=
 =?utf-8?B?WUIzQkVENVBmRnZNRUJvRkZoa0pVL252SnV3MUlxNWYzZXBUTGVLSU13cWRF?=
 =?utf-8?B?UTVwWXdZcUdvalpaR1pXbUpQTXJhOEI3T2hDWDFFTEoyazh4VVpoUGl3dURK?=
 =?utf-8?B?MHV5K3FTazVyODNxSXozcHVrOU9lbUtIcWtOaGtRc1ZmeHJZT2xJZ1BUMlcy?=
 =?utf-8?B?V3crRUhweG9lY0l4aXlOZmZTaFlmdGhVUjFtd1BIbnFONE9GeGNMejBIN2Fl?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dc395a-b4de-4b5a-8e54-08dadecab722
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:32:26.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okaf1rGXC5xXbG3Veo3IicxV30fU8lpwvFT04jqLYNnhbC4SGmLo+zwreqgueNbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3074
X-Proofpoint-GUID: BHF4zZDE6wD83bwLp4vbXTCPMXy6Mk6j
X-Proofpoint-ORIG-GUID: BHF4zZDE6wD83bwLp4vbXTCPMXy6Mk6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 6:34 AM, Daan De Meyer wrote:
>>>> On 12/10/22 11:35 AM, Daan De Meyer wrote:
>>>>> These hooks allows intercepting bind(), connect(), getsockname(),
>>>>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
>>>>> socket hooks get write access to the address length because the
>>>>> address length is not fixed when dealing with unix sockets and
>>>>> needs to be modified when a unix socket address is modified by
>>>>> the hook. Because abstract socket unix addresses start with a
>>>>> NUL byte, we cannot recalculate the socket address in kernelspace
>>>>> after running the hook by calculating the length of the unix socket
>>>>> path using strlen().
>>>>
>>>> Yes, although we cannot calculate the socket path length with
>>>> strlen(). But we still have a method to find the path. In
>>>> unix_seq_show(), the unix socket path is calculated as below,
>>>>
>>>>                    if (u->addr) {  // under a hash table lock here
>>>>                            int i, len;
>>>>                            seq_putc(seq, ' ');
>>>>
>>>>                            i = 0;
>>>>                            len = u->addr->len -
>>>>                                    offsetof(struct sockaddr_un, sun_path);
>>>>                            if (u->addr->name->sun_path[0]) {
>>>>                                    len--;
>>>>                            } else {
>>>>                                    seq_putc(seq, '@');
>>>>                                    i++;
>>>>                            }
>>>>                            for ( ; i < len; i++)
>>>>                                    seq_putc(seq, u->addr->name->sun_path[i] ?:
>>>>                                             '@');
>>>>                    }
>>>>
>>>> Is it possible that we can use the above method to find the
>>>> address length so we won't need to pass uaddr_len to bpf program?
>>>>
>>>> Since all other hooks do not need to uaddr_len, you could add some
>>>> new hooks for unix socket which can specially calculate uaddr_len
>>>> after the bpf program run.
>>>
>>> I don't think we can. If we look at the definition of abstract unix
>>> socket in the official man page:
>>>
>>>> abstract: an abstract socket address is distinguished (from a pathname socket) by the fact that sun_path[0] is a null byte ('\0').  The socket's address in this namespace is given by the additional bytes in sun_path that are covered by the specified length of the address structure.  (Null bytes in
>>>> the  name  have  no  special  significance.)   The name has no connection with filesystem pathnames.  When the address of an abstract socket is returned, the returned addrlen is greater than sizeof(sa_family_t) (i.e., greater than 2), and the name of the socket is contained in the first (addrlen -
>>>> sizeof(sa_family_t)) bytes of sun_path.
>>>
>>> This specifically says that the address in the abstract namespace is
>>> given by the additional bytes in sun_path that are covered by the
>>> length of the address structure. If I understand correctly, that means
>>> there's no way to derive the length from just the contents of the
>>> sockaddr structure. We need
>>> the actual length as specified by the caller to know which bytes
>>> belong to the address. Note that it's valid for the abstract name to
>>> contain Null bytes, so we cannot use those in any way or form to
>>> detect whether further bytes belong to the address or not. It seems
>>> valid to have an abstract name
>>> consisting of 107 Null bytes in sun_path.
>>
>> Okay, it looks like bpf program is able to set abstract name as well.
>> It would be good we have an example for this in selftest.
>>
>> With abstract address setable by bpf program, I guess you are right,
>> we have to let user to explicitly tell us the address length.
>>
>> I assume it is possible for user to write an address like below:
>> "a\0b\0"
>> addr_len = offsetof(struct sockaddr_un, sun_path) + 4
>> but actually it is illegal, right? We have to validate the
>> legality of sun_path/addr_len beyond unix_validate_addr(), right?
> 
> This is not actually illegal according to the man page I think, let's
> look at the following quote from the man page:
> 
>>   Pathname sockets
>>       When binding a socket to a pathname, a few rules should be observed for maximum portability and ease of coding:
>>
>>       *  The pathname in sun_path should be null-terminated.
>>
>>       *  The length of the pathname, including the terminating null byte, should not exceed the size of sun_path.
>>
>>       *  The addrlen argument that describes the enclosing sockaddr_un structure should have a value of at least:
>>
>>              offsetof(struct sockaddr_un, sun_path)+strlen(addr.sun_path)+1
>>
>>          or, more simply, addrlen can be specified as sizeof(struct sockaddr_un).
> 
> So when doing a pathname based path, the address length is allowed to
> be bigger than the actual path. So I don't think
> we need to do any more validation than what is done by
> unix_validate_addr(). The selftests are already using abstract
> unix sockets because they don't need any cleanup.

What about smaller, address "abc", and the length is
   offsetof(struct sockaddr_un) + 2

> 
> 
> On Tue, 13 Dec 2022 at 21:54, Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 12/13/22 3:36 AM, Daan De Meyer wrote:
>>>> On 12/10/22 11:35 AM, Daan De Meyer wrote:
>>>>> These hooks allows intercepting bind(), connect(), getsockname(),
>>>>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
>>>>> socket hooks get write access to the address length because the
>>>>> address length is not fixed when dealing with unix sockets and
>>>>> needs to be modified when a unix socket address is modified by
>>>>> the hook. Because abstract socket unix addresses start with a
>>>>> NUL byte, we cannot recalculate the socket address in kernelspace
>>>>> after running the hook by calculating the length of the unix socket
>>>>> path using strlen().
>>>>
>>>> Yes, although we cannot calculate the socket path length with
>>>> strlen(). But we still have a method to find the path. In
>>>> unix_seq_show(), the unix socket path is calculated as below,
>>>>
>>>>                    if (u->addr) {  // under a hash table lock here
>>>>                            int i, len;
>>>>                            seq_putc(seq, ' ');
>>>>
>>>>                            i = 0;
>>>>                            len = u->addr->len -
>>>>                                    offsetof(struct sockaddr_un, sun_path);
>>>>                            if (u->addr->name->sun_path[0]) {
>>>>                                    len--;
>>>>                            } else {
>>>>                                    seq_putc(seq, '@');
>>>>                                    i++;
>>>>                            }
>>>>                            for ( ; i < len; i++)
>>>>                                    seq_putc(seq, u->addr->name->sun_path[i] ?:
>>>>                                             '@');
>>>>                    }
>>>>
>>>> Is it possible that we can use the above method to find the
>>>> address length so we won't need to pass uaddr_len to bpf program?
>>>>
>>>> Since all other hooks do not need to uaddr_len, you could add some
>>>> new hooks for unix socket which can specially calculate uaddr_len
>>>> after the bpf program run.
>>>
>>> I don't think we can. If we look at the definition of abstract unix
>>> socket in the official man page:
>>>
>>>> abstract: an abstract socket address is distinguished (from a pathname socket) by the fact that sun_path[0] is a null byte ('\0').  The socket's address in this namespace is given by the additional bytes in sun_path that are covered by the specified length of the address structure.  (Null bytes in
>>>> the  name  have  no  special  significance.)   The name has no connection with filesystem pathnames.  When the address of an abstract socket is returned, the returned addrlen is greater than sizeof(sa_family_t) (i.e., greater than 2), and the name of the socket is contained in the first (addrlen -
>>>> sizeof(sa_family_t)) bytes of sun_path.
>>>
>>> This specifically says that the address in the abstract namespace is
>>> given by the additional bytes in sun_path that are covered by the
>>> length of the address structure. If I understand correctly, that means
>>> there's no way to derive the length from just the contents of the
>>> sockaddr structure. We need
>>> the actual length as specified by the caller to know which bytes
>>> belong to the address. Note that it's valid for the abstract name to
>>> contain Null bytes, so we cannot use those in any way or form to
>>> detect whether further bytes belong to the address or not. It seems
>>> valid to have an abstract name
>>> consisting of 107 Null bytes in sun_path.
>>
>> Okay, it looks like bpf program is able to set abstract name as well.
>> It would be good we have an example for this in selftest.
>>
>> With abstract address setable by bpf program, I guess you are right,
>> we have to let user to explicitly tell us the address length.
>>
>> I assume it is possible for user to write an address like below:
>> "a\0b\0"
>> addr_len = offsetof(struct sockaddr_un, sun_path) + 4
>> but actually it is illegal, right? We have to validate the
>> legality of sun_path/addr_len beyond unix_validate_addr(), right?
>>
>>>
>>>
>>> On Tue, 13 Dec 2022 at 06:20, Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/10/22 11:35 AM, Daan De Meyer wrote:
>>>>> These hooks allows intercepting bind(), connect(), getsockname(),
>>>>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
>>>>> socket hooks get write access to the address length because the
>>>>> address length is not fixed when dealing with unix sockets and
>>>>> needs to be modified when a unix socket address is modified by
>>>>> the hook. Because abstract socket unix addresses start with a
>>>>> NUL byte, we cannot recalculate the socket address in kernelspace
>>>>> after running the hook by calculating the length of the unix socket
>>>>> path using strlen().
>>>>
>>>> Yes, although we cannot calculate the socket path length with
>>>> strlen(). But we still have a method to find the path. In
>>>> unix_seq_show(), the unix socket path is calculated as below,
>>>>
>>>>                    if (u->addr) {  // under a hash table lock here
>>>>                            int i, len;
>>>>                            seq_putc(seq, ' ');
>>>>
>>>>                            i = 0;
>>>>                            len = u->addr->len -
>>>>                                    offsetof(struct sockaddr_un, sun_path);
>>>>                            if (u->addr->name->sun_path[0]) {
>>>>                                    len--;
>>>>                            } else {
>>>>                                    seq_putc(seq, '@');
>>>>                                    i++;
>>>>                            }
>>>>                            for ( ; i < len; i++)
>>>>                                    seq_putc(seq, u->addr->name->sun_path[i] ?:
>>>>                                             '@');
>>>>                    }
>>>>
>>>> Is it possible that we can use the above method to find the
>>>> address length so we won't need to pass uaddr_len to bpf program?
>>>>
>>>> Since all other hooks do not need to uaddr_len, you could add some
>>>> new hooks for unix socket which can specially calculate uaddr_len
>>>> after the bpf program run.
>>>>
>>>>>
>>>>> This hook can be used when users want to multiplex syscall to a
>>>>> single unix socket to multiple different processes behind the scenes
>>>>> by redirecting the connect() and other syscalls to process specific
>>>>> sockets.
>>>>> ---
>>>>>     include/linux/bpf-cgroup-defs.h |  6 +++
>>>>>     include/linux/bpf-cgroup.h      | 29 ++++++++++-
>>>>>     include/uapi/linux/bpf.h        | 14 ++++--
>>>>>     kernel/bpf/cgroup.c             | 11 ++++-
>>>>>     kernel/bpf/syscall.c            | 18 +++++++
>>>>>     kernel/bpf/verifier.c           |  7 ++-
>>>>>     net/core/filter.c               | 45 +++++++++++++++--
>>>>>     net/unix/af_unix.c              | 85 +++++++++++++++++++++++++++++----
>>>>>     tools/include/uapi/linux/bpf.h  | 14 ++++--
>>>>>     9 files changed, 204 insertions(+), 25 deletions(-)
>>>>>
>> [...]
