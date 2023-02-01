Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5D687105
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 23:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBAWe2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 17:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAWe1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 17:34:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80524171D
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 14:34:25 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311LE1sc018652;
        Wed, 1 Feb 2023 22:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QWHPlKMxI2/Q0zNF3pMkJPzuZYkgnzydxFIb2EoFHUE=;
 b=x17CO5Ze4L1TXUxmpLLuMpHpY6haGYgxRLxOpukOpJqKW4WFGOIYGXCDeFh8rh4NsKvx
 BiB/06HE5fGktkq8iHt9ruhj+BR5yBvnhbIosJeGL2WyOY4dImSRr1uZfDvbD70IvRO3
 hVO8bNu/iZCeA924Idm2pl+B2QIVzGeygmfPBceJH/dFjTgnGztaZir7IHtwPIDv6/Cn
 pgQvX/NDP+G8y3eZR9xIOOOIr6LSikJ3Aa3qhmXzs453TdA3wNmxItxef7AeAOs1n8j1
 PeKMMiZLHMqxNZFJkFlG93kAMNqW+uODqL2wZV4VA6GKQhYwRpSNoY1J8oB6zD5t8R7R 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hhhgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 22:34:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311LM7wh031547;
        Wed, 1 Feb 2023 22:34:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5ersxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 22:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEOA6QDYoVNeZMfsE1cJxPKXKe0n3VPhmLU+APYIvpOvJ60YHMzbOU7p37m85QUyw9h3o41KGXxZnM0IxRyskld/Vovszk+cdjNquvC61PvqDUZLA5ckdA2lZQ+VTN4d132nQUhdEPp0qgbuqARVh4JMyMEl8R7E+tp5oamZLbNIoEjlkCQ/ySWr/PuHOQcTZlGlvDty+1PhlD9gsQACR1Gp1CweUXNKeiEh+pXBYsxkx9e3w7XYFuEN7t1fNzHzcR+pI6MKjQkeRvQie6PzKVYIzaHUObPm97JXhGSKDOAjctL0W33I6Pi4O4T7DmGJq2rrQYkEyA8zpgXq+KoZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWHPlKMxI2/Q0zNF3pMkJPzuZYkgnzydxFIb2EoFHUE=;
 b=DWaThtrHd6T94UGZvoEEquqTFKu3on26Z3a53YvN+KWbYhbtjxGoaLrBsAyAR3XbTs0KqBWvW18m0d1geXnmV8EaarSL2HyiHVWJ8cpBQCxoy0Wh9tCBOugG9gKDAUF352AS+r47EbhFWX4/dftyGE/dIDjz0hsri4qIliPrGvYRgFfIzZYKm+OMCjHJiEGn3Zn+nFNklilAITEFxpQTQ45T1jcq/68ioXp9ZTOuZ4//geAXde0NVzvUYNmDUQjiLD7xgf248CUaNtVQr3/d224CImLO8WOd7pM3SuLJwzOGivFWD0S8J53M7UV3JNgbfVdaK6nEeNeicXauMV4/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWHPlKMxI2/Q0zNF3pMkJPzuZYkgnzydxFIb2EoFHUE=;
 b=juIAcQ46M02tlhcO4AKiVGSZkpaiMMN/vPJfQ0cbQdtdX3d6vz7KZ/sfH21ptryEkCxiDBVVRPUOJauBHSF2gzia2WW8NoK18PsFIwbrrnupnkww04FKrCpnuBZQ1GtlpMLfwyX4F0acWEd8RvNwe+EfoKrVyxK6nPY+8hkMj/U=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN7PR10MB6595.namprd10.prod.outlook.com (2603:10b6:806:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Wed, 1 Feb
 2023 22:34:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 22:34:01 +0000
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
From:   Alan Maguire <alan.maguire@oracle.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
 <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org> <Y9qC5UQaw9g6cPwz@maniforge>
 <CAADnVQJQQQNw0X-jDXquFYcYeSb0f5T3657KqC8+YevFO6A0cA@mail.gmail.com>
 <Y9qa+yFq+8jT+niu@kernel.org>
 <a9679d64-4860-a404-6030-22e104aec67f@oracle.com>
Message-ID: <151d1e2f-1c78-2d9d-ae65-a6da97c23311@oracle.com>
Date:   Wed, 1 Feb 2023 22:33:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <a9679d64-4860-a404-6030-22e104aec67f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN7PR10MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 764c905d-1daf-4a3a-6334-08db04a46abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: os6WdopyNMOvqBMtyX8i0X/8UWGej7H06v41CQpSPd1T8l1dpgw7F/mTIY6r4M0ZH+YYQGFyVhA7Kr0xbiVKIiOGibCHx2dP0XKzdfXDgufU/XcZzv8ZaiWcsGiq2lyDEp5wPqNpyiJEFPxY59PqluQXIPLvxp03ntIKXt4iti8rZy4QcWRh0+5VyIREqpdn9MTd2exTSczuainp6NiPcTLr8PH3c+D7Q9m5kbA8MhGbfUScnAHDqjsguvCNGFZTUdFVkQnxk0GXRak1w7ovl4vgoV2UNXD88dqFJTdwOESiSM8slZPUrcXScgX2HdgGSONbLs0VCbyVGKexvUMu+RHQoIKjX9A4srtL8zlJzuZEogk+T/TDGNZCMdjtr06i/6/gK1DJJMPRviojJ15jwxp/fvwZrsAz6EyuN1Ao97oA5nurik4QlkZCH20bATkQXH6N+hp4oz8z+nMxBx14uuYkpCMEfDPm0HqpNUV1fPSm5pxAxHijQZWUek2hw3BfGD98jW2GqukLR7S9hGj2Z8V58AyuCQ13KmXQ9MzvnmbzPcYwCEopamSza+GOyijzLidWPeeonsPGw8DGeP/la1RqngI5o/BhkWVzOY3tvzRmWYuNpTwB/HtkUpzMD1QkLT51eaGcIsHfNLTn+IKo4zn5O49/L3um6Vx6ZqJUq4jDYISx6gc8iUXzjXDgwr+ysHMyskcWuagVlLUPM99mrWLRTP4GpZICKc570lraVjBUrX8dmwN1WLDiXK3WGtKCjHbhu7vR2SJ5GpLq6GLP5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(7416002)(41300700001)(66946007)(66476007)(8676002)(66556008)(8936002)(4326008)(31686004)(83380400001)(316002)(30864003)(54906003)(44832011)(186003)(2906002)(36756003)(5660300002)(6512007)(110136005)(6506007)(6666004)(86362001)(6486002)(53546011)(31696002)(966005)(2616005)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNNZU80ZGpwSDIyTEVZQVlISUY2bm5FS0VjUWtjelJmQ1NhL0tYSXZ1N3B3?=
 =?utf-8?B?UHZMUXd1T2xiWGZteThlbTJGa2V1OGcvbXM3alE2NDFOZUJTQkdtMC9mdVlV?=
 =?utf-8?B?amVRZEdPVWQ0THpsMWFKTDBRcVZQVGZsK0VmaittaE1ZSk0zbWhjc01IZ0Iy?=
 =?utf-8?B?VC8zKzFPc2Y3MDV0TUM1cGRwcVd0NnBLVEFGeUZtU0w3c2xoWk1OV2I1RURI?=
 =?utf-8?B?ZSt2bVlvcUpON2ptSGxVU3M0dTZKSTFmTjJTYW4yQkNhZDQrNzhFcUFkcGoy?=
 =?utf-8?B?Y0dYOEhzcXM1ejcrU0pMTUFyZlZMc3dkeE5mdDdER0RjNzdZTUdUcDhoazZW?=
 =?utf-8?B?MDFVKzVUU3d0RFdJTElEVWM0TlFsZXNYeFZHSXcrSFNFQW9sVVdSOUxVOWky?=
 =?utf-8?B?UGJ2VTlYSDJibUlaRnhIQ3ByaW9PNUxUYzJ5VEc1WU9HUkF2dDVWd1FlTXIr?=
 =?utf-8?B?YzMvb1pMaCtYZmsyRGpqVnBqN2g3dldoSkhqZHBRSzVrOVh3RFVFSFZkcERr?=
 =?utf-8?B?Syt6eDEwTms4UWlkNWg2RDh1dEw1QVdsdHBITVkrWXplbFFsZFZiVmVWcC9U?=
 =?utf-8?B?RENyNi9reTd3V0hObU12ZWpQYytqS2gzYmJnVUxCQjkxTzhlc3FCV0FsWnRt?=
 =?utf-8?B?aGVXTHFJY01xQzJpL3JOWlFkeGxncEdRanNDRGtoeXRwT1ZGWkduMXFZck5X?=
 =?utf-8?B?RDdJN1lSbVY0MndRR294cEsxVEdYazdMOG5rbDNGT09TdU9jbEp5RDI3cWJS?=
 =?utf-8?B?Tmg0UEJMbThFZkFTK1RPY09MTGhzYmlGdnMwQ1FaMXFoNzFFM216ajBGd29W?=
 =?utf-8?B?Znp6Y3BaK0hUTmVIVkZxRktGakxzZUVFT24zWUE1YTYxaDljRFFGU0YvcjQ4?=
 =?utf-8?B?TnkrdkFTNnF5UUFlYmZwTXVaajd6NVgrSmJWUGtndW45bGdoeGFVUUxxbzBM?=
 =?utf-8?B?aVZ4VkVQZ1ZlV2JMcmZCYTJjSzVndUZrcUFFNjRwY0ZlSUVGMWlWYkgxSDk2?=
 =?utf-8?B?RENEdTZrNFBuTWt1RWZOdEFiRFJMYWZkck13WGMycWFOZS9pckV3ckl1TVBY?=
 =?utf-8?B?YXFMV3pYdmZ3VEVBTG5qZVBTSlo5Vjd5L3NOeURoVVBzcjB3NjdBdzFNV0dG?=
 =?utf-8?B?ZWtCMXlBZXZkRUVoMXk5dW9xemlkeUJWUnVDN3VId0poejF2bHVFZGdkLzlH?=
 =?utf-8?B?Nm1uNjhNdzBSSEVoQ1FIU1VVbllISER2T0prcHYzMUlONThGOXBTVmxrOGdq?=
 =?utf-8?B?WHpKbEw1bkQwRnB3RFhqaDRvaTFBL294UzdEd3ZoN1V1dkcrZnBrTWYyTlpU?=
 =?utf-8?B?dHlMTE1STE4rcWtlRzJwTlhqMFdmcjFFc3d0bG5wQVhaMW5kTE9YdlVTTW9U?=
 =?utf-8?B?YnRnRHAzZzF6Umt3QWRHRVpUVFFZQm9uZHErOU1BWVhRbGE0NkIzMHF1UTNC?=
 =?utf-8?B?cTZ1SFpOV3lMMW9mMmIrVVU1UXRHT3dRVHBBQ0Yyb3I4aEJGWWNobktHM2hQ?=
 =?utf-8?B?RGY5cFJwclNxczBTNVFGaXpYOVpXRTBQWVlocEE3T1JQdEFwRk5Ia0RrcTNn?=
 =?utf-8?B?V00vSFRVaHFLOUJpZllwNHBHNzk0WG1wQUlhSGZCSXdoUWlFWG5Rb09qaE5k?=
 =?utf-8?B?b0djdkEveFhzN1pvMzQ5TE0va1BjV1VIeUttVk95My8waGhVRDhGbDVyTHZ3?=
 =?utf-8?B?Mkw3NUlaM2NidWdxY0ZIRTRYM0M2VnpEdUI1YW5oTUhiVHRuV0NEUEc5ZFMz?=
 =?utf-8?B?aHUyVXY4MTdvQVdweUpPajdrclZjclc2NC8vNmdOa0tWakVKM3ZWaTNueG9m?=
 =?utf-8?B?bVBaZ1owdUsxMVBlUEJsV2NobEVSY084UHNMaFFIeHA3TThtR0QzTkkzay8v?=
 =?utf-8?B?eVR2a3RQNURGYU5uVG5pYXE3aUdRM1NYZHJDUTY1MmVnTWd5V25ORzRXRms5?=
 =?utf-8?B?UlpvRnlGNUIyQ0tnQ0tTMTFvbWIwazBLYTA2eW9qazFiVEtsYW9SR2hWeVU2?=
 =?utf-8?B?c1M4eG5jaHhEREkrRW9RQllpNDRFZk9XR29odDMwR3NFYnVYemo4elRYd2Ft?=
 =?utf-8?B?NllrUnh3NU9wWlluLzRBei9sK2hxU2JGQUFTR0FUR0ovc25hKzZCWk1QNEpq?=
 =?utf-8?B?VWpiSDlYT3ZOaXAvL21DblJheCtoVUd6bDNXQTdRMGJ2TXhOWG1EL3kvR3lq?=
 =?utf-8?Q?yDeoznNO/oyGsv6CKBAj8DQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RUVpRTgxV2s4U0d5Vk42WUxHejJ5MVJCWnNsUndrcERZK1kyTWt4UlRTV1o4?=
 =?utf-8?B?TEs1MTVuNlFuVUtjQU1kT1dwS0thcUxjMmQxanB5M0kydm1wa2pKUE5KUHlI?=
 =?utf-8?B?dXZCc2s2NzcxU29TbVBSWHF4aEZUdmFXVGQ0dW9kdTNhd2tyMy9QdVJ2aVlW?=
 =?utf-8?B?Z0JUV0kxOWhEV216OFljUC9IZUdmelBOdlpwY2R2TmxtMERTWmg4U3RsUW1V?=
 =?utf-8?B?WmN3QVhRc0NuN2FsaTNOTHFueEd4RlNmZGJrUzZCam5aTENhYWoxNlpBbXlz?=
 =?utf-8?B?WGxsNmpMZlZGM0MwRTZNZ0QwRVVhb08yTWF3UkRXNlVYOUoyMVpDaVREMGtR?=
 =?utf-8?B?S25FZThpMWdEYVdFODNXbmFnTDF6dlprY1VJNFlyWVFnRVRCZHpMQTd3R01F?=
 =?utf-8?B?dU5xQlc2ejVCK0crd1c5bjNYMkEvVU5IYy9HN1ovbWhwQnM3WlFmS0xzejJk?=
 =?utf-8?B?MVdQMDc4czhQUTBDeUJReUJhZnMyQ01mWjhCcWJxNlFGYlFxM1psRk41UGRQ?=
 =?utf-8?B?SHdOSTE1V04wOHlPc0JBZUdQT0pRcWxRaXFzKzN6MzE1bzlleUpnakZ6ZStk?=
 =?utf-8?B?Y0lkT3N2NXNlOG42TXhCRFIwRUdtTjgyVkE1dVF6SWZSbHJlaENjcklUY1dQ?=
 =?utf-8?B?TDRqZ2FhNzFSczltSUNEMUcyWmlDQjNkcEN2SXBHK091a3NSQ2FJVUliRENq?=
 =?utf-8?B?b2c2VmZPem00WWQxdXNwd1d1YzRNdHVrQjZzakZSWFhsRzFyd0NBbXlhNEox?=
 =?utf-8?B?Z1FHS0hBK203NHE0ZU91WG1qeGxaMy91QktQOUZJbHd2c0U4MmR0NXQ0UnNV?=
 =?utf-8?B?NWVhL3Y0a3J2TVZVN3VleVhINURpZk1taUpCbU5xRXRwU3JqY1cramNOK1RF?=
 =?utf-8?B?ZHY4YnlyV2JvSHIyYzNDOGtKUk53YWNQa1NYekdDUENMekoybElodnFicER1?=
 =?utf-8?B?Vmx4OVNmNHJVbCtPYlFnT1JsUUFBN2I0cDNERnpLazBoM1hLMHhQQTA3bTZw?=
 =?utf-8?B?Slg5bU0yUXF3SjZPS3ptRDB1MHhRU3VXSWRYY1krV01SekdRN1pvK2oybEVJ?=
 =?utf-8?B?cTdTbjcvOXZZYWNCU2N1L1ppcS95cDFXYitCME9tN053cjh2c1dGaHc4WGRP?=
 =?utf-8?B?enE1Y2NEWEtVZ2dRRWgzNWJRcTg3TnBxR3RheHdFRk5zSVViVVBFN0J2Nkhq?=
 =?utf-8?B?cUJ6eEt5WVUveGY3RmRqTlFLUEJmY0tEc1FPZVlFTkk4anMzTWRjREhQZ1ZO?=
 =?utf-8?B?L3orRmZjdUdHNEJJaWdIUExvTDFqT1lCdnY3a2drVTQ1U1dzRUQ2WW9hb3NZ?=
 =?utf-8?Q?zDjKClh3DACG0HbFkQY/SCA1pvj1rEP7n0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764c905d-1daf-4a3a-6334-08db04a46abf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 22:34:01.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKOJoZu3eNWgWxiOfHhOe8l0RPNpeuQt6W72eCZ8CgHBDgCyqBzgRAX66UrpbLJJc7k7BkQzeApqmvHS+9TBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010189
X-Proofpoint-GUID: RhuJgGMTKuxav_1luXL77ClBiTAUHFv9
X-Proofpoint-ORIG-GUID: RhuJgGMTKuxav_1luXL77ClBiTAUHFv9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023 17:18, Alan Maguire wrote:
> On 01/02/2023 17:01, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Feb 01, 2023 at 08:49:07AM -0800, Alexei Starovoitov escreveu:
>>> On Wed, Feb 1, 2023 at 7:19 AM David Vernet <void@manifault.com> wrote:
>>>>
>>>> On Wed, Feb 01, 2023 at 12:02:07PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>> Em Wed, Feb 01, 2023 at 01:59:30PM +0000, Alan Maguire escreveu:
>>>>>> On 01/02/2023 03:02, David Vernet wrote:
>>>>>>> On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
>>>>>>>> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
>>>>>>>>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
>>>>>>>>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
>>>>>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>>>>>>>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>>>>>>>>> +++ b/dwarves.h
>>>>>>>>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>>>>>>>>>>>>>>   uint8_t          has_addr_info:1;
>>>>>>>>>>>>>>>>>>   uint8_t          uses_global_strings:1;
>>>>>>>>>>>>>>>>>>   uint8_t          little_endian:1;
>>>>>>>>>>>>>>>>>> + uint8_t          nr_register_params;
>>>>>>>>>>>>>>>>>>   uint16_t         language;
>>>>>>>>>>>>>>>>>>   unsigned long    nr_inline_expansions;
>>>>>>>>>>>>>>>>>>   size_t           size_inline_expansions;
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>>>>>>>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
>>>>>>>>>>>>>>>> defined if using a very old elf.h; below works around this
>>>>>>>>>>>>>>>> (dwarves otherwise builds fine on this system).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Ok, will add it and will test with containers for older distros too.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
>>>>>>>>>>>>>> repo at:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It failed yesterday and today due to problems with the installation of
>>>>>>>>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
>>>>>>>>>>>>>> notifications floating by.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
>>>>>>>>>>>>>> iterator that Jiri noticed.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
>>>>>>>>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
>>>>>>>>>>>>> from the BTF representation, and as a result:
>>>>>>>>>>>>>
>>>>>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>>>>>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>>>>>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>>>>>>>>>>>>>
>>>>>>>>>>>>> Not sure why I didn't notice this previously.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
>>>>>>>>>>>>>
>>>>>>>>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>>>>>>>> {
>>>>>>>>>>>>>         return -EOPNOTSUPP;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> looks like this:
>>>>>>>>>>>>>
>>>>>>>>>>>>>    <8af83a2>   DW_AT_external    : 1
>>>>>>>>>>>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
>>>>>>>>>>>>>     <8af83a6>   DW_AT_decl_file   : 5
>>>>>>>>>>>>>     <8af83a7>   DW_AT_decl_line   : 737
>>>>>>>>>>>>>     <8af83a9>   DW_AT_decl_column : 5
>>>>>>>>>>>>>     <8af83aa>   DW_AT_prototyped  : 1
>>>>>>>>>>>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
>>>>>>>>>>>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
>>>>>>>>>>>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>>>>>>>>>>>>>     <8af83b3>   DW_AT_name        : ctx
>>>>>>>>>>>>>     <8af83b7>   DW_AT_decl_file   : 5
>>>>>>>>>>>>>     <8af83b8>   DW_AT_decl_line   : 737
>>>>>>>>>>>>>     <8af83ba>   DW_AT_decl_column : 51
>>>>>>>>>>>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
>>>>>>>>>>>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>>>>>>>>>>>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
>>>>>>>>>>>>>     <8af83c4>   DW_AT_decl_file   : 5
>>>>>>>>>>>>>     <8af83c5>   DW_AT_decl_line   : 737
>>>>>>>>>>>>>     <8af83c7>   DW_AT_decl_column : 61
>>>>>>>>>>>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
>>>>>>>>>>>>>
>>>>>>>>>>>>> ...and because there are no further abstract origin references
>>>>>>>>>>>>> with location information either, we classify it as lacking
>>>>>>>>>>>>> locations for (some of) the parameters, and as a result
>>>>>>>>>>>>> we skip BTF encoding. We can work around that by doing this:
>>>>>>>>>>>>>
>>>>>>>>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>>>>>>>
>>>>>>>>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
>>>>>>>>>>>>
>>>>>>>>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
>>>>>>>>>>>> applied to arguments.
>>>>>>>>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
>>>>>>>>>>>> the way we do in selftests.
>>>>>>>>>>>
>>>>>>>>>>> There is also
>>>>>>>>>>> # define __visible __attribute__((__externally_visible__))
>>>>>>>>>>> that probably fits the best here.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> testing thus for seems to show that for x86_64, David's series
>>>>>>>>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
>>>>>>>>>> to cover recently-arrived kfuncs like cpumask) is sufficient
>>>>>>>>>> to avoid resolve_btfids warnings.
>>>>>>>>>
>>>>>>>>> Nice. Alexei -- lmk how you want to proceed. I think using the
>>>>>>>>> __bpf_kfunc macro in the short term (with __used and noinline) is
>>>>>>>>> probably the least controversial way to unblock this, but am open to
>>>>>>>>> other suggestions.
>>>>>>>>
>>>>>>>> Sounds good to me, but sounds like __used and noinline are not
>>>>>>>> enough to address the issues on aarch64?
>>>>>>>
>>>>>>> Indeed, we'll have to make sure that's also addressed. Alan -- did you
>>>>>>> try Alexei's suggestion to use __weak? Does that fix the issue for
>>>>>>> aarch64? I'm still confused as to why it's only complaining for a small
>>>>>>> subset of kfuncs, which include those that have external linkage.
>>>>>>>
>>>>>>
>>>>>> I finally got to the bottom of the aarch64 issues; there was a 1-line bug
>>>>>> in the changes I made to the DWARF handling code which leads to BTF generation;
>>>>>> it was excluding a bunch of functions incorrectly, marking them as optimized out.
>>>>>> The fix is:
>>>>>>
>>>>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>>>>> index dba2d37..8364e17 100644
>>>>>> --- a/dwarf_loader.c
>>>>>> +++ b/dwarf_loader.c
>>>>>> @@ -1074,7 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>>>>>                         Dwarf_Op *expr = loc.expr;
>>>>>>
>>>>>>                         switch (expr->atom) {
>>>>>> -                       case DW_OP_reg1 ... DW_OP_reg31:
>>>>>> +                       case DW_OP_reg0 ... DW_OP_reg31:
>>>>>>                         case DW_OP_breg0 ... DW_OP_breg31:
>>>>>>                                 break;
>>>>>>                         default:
>>>>>>
>>>>>> ..and because reg0 is the first parameter for aarch64, we were
>>>>>> incorrectly landing in the "default:" of the switch statement
>>>>>> and marking a bunch of functions as optimized out
>>>>>> because we thought the first argument was. Sorry about this,
>>>>>> and thanks for all the suggestions!
>>>>
>>>> Great, so inline and __used with __bpf_kfunc sounds like the way forward
>>>> in the short term. Arnaldo / Alexei -- how do you want to resolve the
>>>> dependency here? Going through bpf-next is probably a good idea so that
>>>> we get proper CI coverage, and any kfuncs added to bpf-next after this
>>>> can use the macro. Does that work for you?
>>>
>>> It feels fixed pahole should be done under some flag
>>> otherwise when people update the pahole the existing and older
>>> kernels might stop building with warns:
>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>>> ...
>>>
> 
> Good point, something like
> 
> --skip_inconsistent_proto	Skip functions that have multiple inconsistent
> 				function prototypes sharing the same name, or
> 				have optimized-out parameters.
> 
> ? Implementation needs a bit of thought though because we're
> not really doing the same thing that we were before. Previously we
> were adding the first instance of a function in the CU we came across.
> Probably safest to resurrect that behaviour for the legacy
> non-skip-inconsistent-proto case I think. The final patch handling
> inconsistent function prototypes will need to be reworked a bit to 
> support this, since we tossed this approach and used saving/merging 
> multiple instances in the tree instead.  Once I've built bpf trees I'll
> have a go at getting this working.
> 
>>> Arnaldo, could you check what warns do you see with this fixed pahole
>>> in bpf tree ?
>>
>> Sure.
>>
> 
> I can collect this for x86_64/aarch64 too; might take a few hours
> before I have the results.
>

The results I'm seeing with the bpf tree across x86_64 and aarch64 are 
consistent using the updated pahole:

WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
WARN: resolve_btfids: unresolved symbol bpf_ct_change_status

 
>>> If there are only few warns then we can manually add __used noinline
>>> to these places, push to bpf tree and push to stable.
>>>
>>> Then in bpf-next we can clean up everything with __bpf_kfunc.
>>

If the skipping of inconsistent prototype functions happens under 
a flag and not by default, presumably we'd have something like
a 3-patch series for bpf; one patch with an update to scripts/pahole-flags.sh

if [ "${pahole_ver}" -ge "125" ]; then
	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto"
fi

...so that we can enable building with 1.25, and then two additional patches adding
__used noinline prefixes to bpf_ct_change_status and bpf_task_kptr_get(); splitting 
these out into separate patches would probably make sense as different stable trees
might need one but not the other. I _think_ that's what you have in mind, is that
right?
