Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2359E69E3F8
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjBUPxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjBUPxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:53:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E69009
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:53:36 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LE0H83018127;
        Tue, 21 Feb 2023 15:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qqIGN/03xCVuH0JMsa5IuFWaOQK5pW4FxNSTCv6JVto=;
 b=Nlk8lx9o8NtItaFLQlFUZuoGcdPdzooarz59HxrltklSCQTdk/9LfXMJZb10/lJh4UlY
 WHl7G/6IgrRvHsHoeLC/CJa+FOPxwPg4jjw3miZq70eo/OJzXi29lUNKh2pSKI/EHwbS
 vwlAtshSpb/ygOEhVQfJOKCfrt9034f8VJTAdjnIi8dRI7l6OL16y58Du5JQl2ARD1QO
 0GNc6xG/XBItWN63iPNtQbqeNwkMXGPJy+UiTYidBm7h9t22kcl9tOagw4j/CgDfwCzH
 fQNBRMO2sdKD4PR6AkJ0umrcZJZUHQRXlaLb1fKc3Ker+5YA/2G2Pbqn6RBOcYoRcLxW LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3dhvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:53:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LFKpRb006871;
        Tue, 21 Feb 2023 15:53:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4btv1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:53:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKbPo52JPKrSMvVFW+FBeervvN7/O7RxHzJN0XBJ8NMA5f1K5yQFC0ax+MaBTrxyrwKMIlF4qq02WXzYRECQPdUw/TZaabpj3hXRdykoemXg5oCTYlWTMwDautAR/N+0vPvzOz2GAiZUZ9cl+B7n4zV3wUykD/vL9B964OdYz0PfbN23DsIm3HjSYRinR4nXYsADWBOKPAHPmEIAxq4g7QohH1ZIO8e4FOIbPRSI6bbIZNJ97oi4JoD2QRFCRCvi+QO23aP3Gz/RKj1tGrSqa9B93ZuGi+Kb3cHLKrzB5WzKWWxUThtfprLBFZwtW9JtFnIHxOHpk9O9QeO3b+nCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqIGN/03xCVuH0JMsa5IuFWaOQK5pW4FxNSTCv6JVto=;
 b=DkJn9ijemgS1rtHzIJgxdMPQen+ykkCj0YTYi8lIqLajAlGtwvIDu+FdyHCPUW4mSAqrnV4XDtCaRLTwVu3MajbuEHBhm/qCqA04jOInVzS/yOLR0ptxtRRFOrfBHgwKooGUvjt1qeouI4CukfF7kOgy+ypOWqP2PRTx9QZn6dLYBmQh5FKrCtGe4tZGk7hNJ6UqYuXmERW+b06HG00Gg7xa+yoWyT88cHtnIcBrY+9Gd13bCg55tPB7s66+qJFHJDNoljxROIEo0qpqUHh6dAduqVa4aeUPWdXOwRzg6Aeg2JyaoVO/qkHUkFmjH3iJH6pQcaYSOOGZkDTioxyqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqIGN/03xCVuH0JMsa5IuFWaOQK5pW4FxNSTCv6JVto=;
 b=hZVnHk9tOE0jWE8oxQ/mINta2/geHPDjNf1wd1dTigZ1sAqzeHhNx3gwre6e+b4sL+BtFAyVgKt5NXUod44fc7MWLJapvHIGF5uCj+n8w+2TqYzYtOtiluYwrqr3gI+4YguWY866obicf5VN1yWhZA8bGbkCbdJqvfyQ6o2KRu8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH8PR10MB6454.namprd10.prod.outlook.com (2603:10b6:510:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Tue, 21 Feb
 2023 15:53:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6134.017; Tue, 21 Feb 2023
 15:53:14 +0000
Subject: Re: [RFC dwarves 1/4] dwarf_loader: mark functions that do not use
 expected registers for params
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
 <1676675433-10583-2-git-send-email-alan.maguire@oracle.com>
 <20230220190335.bk6jzayfqivsh7rv@macbook-pro-6.dhcp.thefacebook.com>
 <0bf3e832-ef5b-6ab5-4d8b-1de8e957e166@oracle.com>
 <20230220223034.sgtda6mcrwuqwvk4@macbook-pro-6.dhcp.thefacebook.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <9f0f94f6-9f8c-f52d-70dd-4aabe742c092@oracle.com>
Date:   Tue, 21 Feb 2023 15:52:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230220223034.sgtda6mcrwuqwvk4@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH8PR10MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f96bc9-ba2d-4425-85d3-08db1423bd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJaGOlMGKsti+mpEH+WXLSZoB438QFK28XfklJPB2/kuD6v5Dv5KnVkgtb3e0vVJaGjEib8n9Wkl3GPiXQlIeIWvxPIQ3TS+qK+8beV40bV/PUNNRrYT1Bx4lfQZclgATrTMR7dJTJrZkkLlaSIc+DjMJB8IxYsiaQXEHABG096lVsdX9x8Gu+4mayT9Xi+OVx/u/R4hXJ4LpyqjP2WbWx7Cd1xuqcs7xkhRnLs8kxeddD5m5UshMEV2mXnpOqn1M2fFmzOjEZ5sMTCJOw1IPpyfz9rZrqIRxCA7CYKLrxPvV6EyHt68tnB5QH+xPz7PiRDd3chFdW0ViR5pDvErJERfA+X8wdsgJ4pGajkE5yMIVu+IDvWPPIKlQ2n6CCL5QpWXA7vrAlRti+PLQTaAUqSaEAVxvlpmKMugHumwsZF2u9gTJaj21hWaRnGT03fUOq45f+DDohQBOgJOdRqVNAGb3GtTD/V5eqCrMOZpO+ZQang0+qX1jnK+WHVok8GOZAUpERL+BpRYGD9+GmZOLTHInNqJuXeWAW5FndkK78U4rdPdUpUk7K93sS3+lEP/yONimjbTL+SdZM3JHmbpMJx2ljEjuEveSCAMBShJ+H1+RMN2R/YQFS0Hk07VfGxjA+4ZFUWU4J/tXfA5VORv12wSy92seAktjB7+QZJkAbQ1q3JWOw3H5VyoagT78tEflO/iEkQA2rD8D5YGgdQ9eTclPGdiNPY8o0ha/n2qUWqE2MAjolRFfNeGPKYqhdup
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199018)(44832011)(30864003)(2906002)(31696002)(86362001)(7416002)(38100700002)(31686004)(6916009)(36756003)(53546011)(6666004)(186003)(6506007)(66556008)(66946007)(8676002)(6512007)(478600001)(66476007)(2616005)(41300700001)(6486002)(4326008)(966005)(8936002)(83380400001)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVESEpmeWc5MlJMck02SWNrRzhLaHFpTG16alRtWjQ2d0VhR2h2UGI3a3Uz?=
 =?utf-8?B?NmZFRFlDUXc4eko0OXRpa25BY0xJRUV0RWk5ZFB4aEx0ajhaanFQbll3SjRM?=
 =?utf-8?B?L0lZQUFDVEhTS2dSakhwNmFJOXBzRGRTaEZ2MkpaUnpnenBtaTM5R0lTaFhs?=
 =?utf-8?B?a0JNdEJ2RUpPNnZacG5mUFd1WTNWelpEQkI4Yk9xSkdCSW1PWUY4U0hyc2lS?=
 =?utf-8?B?TW5yV1V4R2ZscE0xak4wNkVUZ0NRUnIySTdvY1hkQTdTRnVvSHlqOGlBQmdH?=
 =?utf-8?B?TjdPNnJ3ZERwdmN0Q3JiK1RGaVFxTzRRWjI3czlCRFBxbzQrQmxJa0ZCRWFy?=
 =?utf-8?B?WUh0bWpWb1V0Y21xMEk3amQ5NDlLNnpNQ3FFWHdxaTE1djQvSEt5ejc1d3dO?=
 =?utf-8?B?YjZZZndBN3BCWitVaUxPTGJvaHVOT2pKQzdDcFIvYzI5ZnZkQVB4ZjNjSC9N?=
 =?utf-8?B?OWU4SWszeXFuSmpkME45eTVkNGcraFRQTzh6S1NPWjYrcDhUWXdtenJ2SVdp?=
 =?utf-8?B?NE5hZmtXSUVqREJmR05UQWwwU3pjWVZhcmt2dnRHQ0diaEpHbXllejJiQU45?=
 =?utf-8?B?aWpsM3pINU5yKytsM1pPVDQ3VUcyNllVWEh0YlZvV2hvQk5TWmUzSCtjaENE?=
 =?utf-8?B?VnB4T1RZZjBwdi9jbFR5RDVzNTBsdXg3ZmgxMUY5RUplcXIwemRrSmVzZ1Bk?=
 =?utf-8?B?MFJqOW1idm5PN2hzTWQvYUl5bzVLaDQ0ZUJKdkJzNTRRWEtsbzVaMVFJVGtX?=
 =?utf-8?B?R1VKSFgxSkJZbndGbTZqb09hZm9tSXZMY0djbU9qOXp3M0pKOTA2UEV0Vmc5?=
 =?utf-8?B?TGlpR2JrbUl3YjFpTFRVeERtUEIyd3YrZEVQaW4vT1RQV09tNStWYStROWsz?=
 =?utf-8?B?OVIxdEVlN2xqMjkveGUyQWtUT25sZ1M2UXdXZDFxVUNTYnJKUnNWWnRJVGRG?=
 =?utf-8?B?QUNEZG9Nc24xUVJyYVNtTExWb3libWduNVByVVpxUXhXa3M4WCtjcERRUUQz?=
 =?utf-8?B?bXBMMjlXRmg0U3ZUUXllTSt4Wi90UnlGazdXWUVGandsb251eldVL2NYWGhs?=
 =?utf-8?B?TU1sRkF4d2ZlSUJnWW1MTnFIVDNremdqU1kzUDBvUEN2TGhyeElQdUJTOGpy?=
 =?utf-8?B?d1NqVkE0eGxuNlRvWXJOb21rM0N2Z0RaTjhFT3NzTnZYMm82VHcwMElrUVdv?=
 =?utf-8?B?eTAxYjVnTUcreHpLbGc3eDRkZnducnR0U0drQUJUZ21Zb21Zb3FjOERFUWI5?=
 =?utf-8?B?VFRCOWdRbEFhY2hUNElKU3dBcHNLYk93YmZOWUxJQlZPdkZVa3FmUDNZNGVa?=
 =?utf-8?B?RlpRcVk0aW4yVzJoL0tpZ0dOVE1JR2FPVWJONm54aGdNb1pxL1VpZW5qUGRl?=
 =?utf-8?B?U0lYVktrOGt3VnN4RHlmL3E4VTVTcHRjZytFdHdsVktzTlJxem1rYkEyQmhJ?=
 =?utf-8?B?M0trR0hjWFBiRkVsN0dHVDZtaUgxTWM0NDVlOEhFTE1LSmMwZ29GaVdhRmor?=
 =?utf-8?B?b1ViaFZXNE5rWm9YRjU2ZzBmdE5YNHpqMEZLUkRyVFZmemlzK05vcE1rV2lu?=
 =?utf-8?B?TUxPQ0tNb1FNaDcvR1o0dk5iQzNPTUhBTHA4RFR2Szg5RHpZTW9IMHNKUkYv?=
 =?utf-8?B?TEVqUkI2OTcyaSswQlBVL2VTTEdHSVhZcjRGaC8xMmVuLys2TkNpOFdOSUZq?=
 =?utf-8?B?eXpmR3RrckpJR0VkdUtKbzZrN0tTREhBSGViNEZkNjBvRTJqLzNlaHRrbEJm?=
 =?utf-8?B?dmFLSHZ5aUtLMVZ1VXZvUWdNNGtsNmVoNG4wVUUrYTFIU1FiNXkzbDZQaHNn?=
 =?utf-8?B?NU1xYU15ZjJ1aUswUmc1L2lPYjNHN3lLVFR1cmhJSXRBdTgxL2tsWm9oWEFD?=
 =?utf-8?B?OEE3a2t1N1dWTmYrUDk0Y3RyTHFSVkh0ZDhPYXJsaGhUQWE3UnNmc1BwS3dM?=
 =?utf-8?B?UEZwSGVSOW1zTDFzb1RtMHI1cjRaTjdkeHcxUnVabWMyRGlKb2x2Y3BqZEZa?=
 =?utf-8?B?bnNtVEI4RSs5cmExaGNaOU5Ma1VrcE0yU3Y2V3ltME80M0loMlU4REwxSzhq?=
 =?utf-8?B?K0tXN01DNFQyUHFSYmdnNzhDempUaWhqWnRlbnZycEJRTUh2eVpuQW51Q3By?=
 =?utf-8?B?VGlqcU9GME11bmpWOUs2cDA4Z1pYODZqQmI0WjZzSlVJUDdSem53aXM2TjBM?=
 =?utf-8?Q?1PfFaFv85/hHNwW2RkLagHQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WnJIZHB5NVg0NXZ1OTk2WXR3ZlRDL0RSRUovdld6ZmdUQWN2KythbUxiSFNs?=
 =?utf-8?B?SjRSYUpEWUJpKzg2SUlpRi90bVZOSGxJVS9sMHJ0SUJPa0RLWDNLalE5RVFU?=
 =?utf-8?B?SnpIS3JPU2MzRmMzdkQxdjFjL25wNUZJU1d0Y3dubmVEbDFEQzY0MzVJc0Vo?=
 =?utf-8?B?WTFGOGI2dUNQejliUERqdHc3a1V5U2J3aWRWM1VjbnQzdWQ4dEpidmlHWE0v?=
 =?utf-8?B?UHVZSE04N3g4T2tDd0paSmFyb0dVMHVVdzF0dkV5S0puVC9KMVkyTTA2ZFNx?=
 =?utf-8?B?RHROMVZPcFk0VFV5d2xwaENxK3Q3c0NPSWVQOWVGVWc1STBOT21ydDFVZGNq?=
 =?utf-8?B?VUt1blhubVB1dVlPeC9haExmVmlLNzFDYmJrY2g1aUpmU0VycURONU14YjBL?=
 =?utf-8?B?aG5kdWtBN204SnJUU0Y0U012SWx2a0dtQnNwVGkraTZrTDFBdzJ4eTZKR28z?=
 =?utf-8?B?SUhqSEU5VDhLNURWTEFuK1ZpbHAyMFhESDNzWlZZZ05mREZUcnVaREVPOVR6?=
 =?utf-8?B?d1VjZk4yNGZmaFZvY2VJbFVLY000ZU4zcnhEWnIyNkR0NWdFbWVoc3QrTUZu?=
 =?utf-8?B?MThzTjlWWi9rOEJHbk1GMHluZWJXbWhoZzFCUFA1MmV0VUdXcTRvLzJWVVlv?=
 =?utf-8?B?eXRiVjY1bEgvL1B2bFdGSnpBRzNXVXU1VWFzcG5neUJDeFh6OElqMmNBdG5R?=
 =?utf-8?B?WjhqaHh6UXFnSnkybmowcG1JM1l6VkxOU2xkMWZBeDhseDFEOHkyUGhEejdq?=
 =?utf-8?B?Ry9MbUtTWVVIZTdNZ2RPS0xmbUtXKzl1anl0UndUalVDSXZibG1rMk9vT0t0?=
 =?utf-8?B?WldxeUw1eC94c2pJalVRcmZtNTI5TklBeEgyTzdYczl2TUFXU0dMZmllWkRv?=
 =?utf-8?B?VisydklESXNlWGVBck94Z2xmRlZoenJ1bklBWmlyZUVENTlucFdVOU54a2pK?=
 =?utf-8?B?Ymxkb3dGWDFLMkNlUnJLMytoMWRJRDhSR0NjKzJrQWZRckFBb0h0bmhOWFA4?=
 =?utf-8?B?cE9WVnhkVVZkR0NrUk9MR3F6eWhqbWZDWkFyRDNSTzFkQ0tBeEY2TndpUTk0?=
 =?utf-8?B?ZjIrV1VHYWtTQmdsNUJiZ3ZzT0hUbXhUZkZPVjZGOGRCUTliVWpjK3ZlUllZ?=
 =?utf-8?B?QUY0MW1PUUpEcFdxWjkrM2pFbkJTZVIxcDI3L3BRWHZGSTdGcU02SGdPcVNp?=
 =?utf-8?B?Zjk4QkxaYU03U0d1WmlxanpKU01YK2Y4SzB2Y2JML2NvdTVDdFBiMUtIdDNV?=
 =?utf-8?B?anh4V08vTElVd0RZZjFUUFI3U2pyRXJwRC9NRVB3OUUwQ1lvZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f96bc9-ba2d-4425-85d3-08db1423bd72
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 15:53:14.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmSQ4AOV5Fo4cgzc/qvXmsToGqsND84Q8cXBZ99tls0nAzxD8Uah+wle5kfqnlQVueBX+TQPz8EABCpwgWbGgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210132
X-Proofpoint-GUID: RuDonEImHQao7OQmCIecMZonx-WWRxPo
X-Proofpoint-ORIG-GUID: RuDonEImHQao7OQmCIecMZonx-WWRxPo
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20/02/2023 22:30, Alexei Starovoitov wrote:
> On Mon, Feb 20, 2023 at 07:42:15PM +0000, Alan Maguire wrote:
>> On 20/02/2023 19:03, Alexei Starovoitov wrote:
>>> On Fri, Feb 17, 2023 at 11:10:30PM +0000, Alan Maguire wrote:
>>>> Calling conventions dictate which registers are used for
>>>> function parameters.
>>>>
>>>> When a function is optimized however, we need to ensure that
>>>> the non-optimized parameters do not violate expectations about
>>>> register use as this would violate expectations for tracing.
>>>> At CU initialization, create a mapping from parameter index
>>>> to expected DW_OP_reg, and use it to validate parameters
>>>> match with expectations.  A parameter which is passed via
>>>> the stack, as a constant, or uses an unexpected register,
>>>> violates these expectations and it (and the associated
>>>> function) are marked as having unexpected register mapping.
>>>>
>>>> Note though that there is as exception here that needs to
>>>> be handled; when a (typedef) struct is passed as a parameter,
>>>> it can use multiple registers so will throw off later register
>>>> expectations.  Exempt functions that have unexpected
>>>> register usage _and_ struct parameters (examples are found
>>>> in the "tracing_struct" test).
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  dwarf_loader.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++---
>>>>  dwarves.h      |   5 +++
>>>>  2 files changed, 109 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>>> index acdb68d..014e130 100644
>>>> --- a/dwarf_loader.c
>>>> +++ b/dwarf_loader.c
>>>> @@ -1022,6 +1022,51 @@ static int arch__nr_register_params(const GElf_Ehdr *ehdr)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +/* map from parameter index (0 for first, ...) to expected DW_OP_reg.
>>>> + * This will allow us to identify cases where optimized-out parameters
>>>> + * interfere with expectations about register contents on function
>>>> + * entry.
>>>> + */
>>>> +static void arch__set_register_params(const GElf_Ehdr *ehdr, struct cu *cu)
>>>> +{
>>>> +	memset(cu->register_params, -1, sizeof(cu->register_params));
>>>> +
>>>> +	switch (ehdr->e_machine) {
>>>> +	case EM_S390:
>>>> +		/* https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf */
>>>> +		cu->register_params[0] = DW_OP_reg2;	// %r2
>>>> +		cu->register_params[1] = DW_OP_reg3;	// %r3
>>>> +		cu->register_params[2] = DW_OP_reg4;	// %r4
>>>> +		cu->register_params[3] = DW_OP_reg5;	// %r5
>>>> +		cu->register_params[4] = DW_OP_reg6;	// %r6
>>>> +		return;
>>>> +	case EM_X86_64:
>>>> +		/* //en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI */
>>>> +		cu->register_params[0] = DW_OP_reg5;	// %rdi
>>>> +		cu->register_params[1] = DW_OP_reg4;	// %rsi
>>>> +		cu->register_params[2] = DW_OP_reg1;	// %rdx
>>>> +		cu->register_params[3] = DW_OP_reg2;	// %rcx
>>>> +		cu->register_params[4] = DW_OP_reg8;	// %r8
>>>> +		cu->register_params[5] = DW_OP_reg9;	// %r9
>>>> +		return;
>>>> +	case EM_ARM:
>>>> +		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs32/aapcs32.rst#machine-registers */
>>>> +	case EM_AARCH64:
>>>> +		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#machine-registers */
>>>> +		cu->register_params[0] = DW_OP_reg0;
>>>> +		cu->register_params[1] = DW_OP_reg1;
>>>> +		cu->register_params[2] = DW_OP_reg2;
>>>> +		cu->register_params[3] = DW_OP_reg3;
>>>> +		cu->register_params[4] = DW_OP_reg4;
>>>> +		cu->register_params[5] = DW_OP_reg5;
>>>> +		cu->register_params[6] = DW_OP_reg6;
>>>> +		cu->register_params[7] = DW_OP_reg7;
>>>> +		return;
>>>> +	default:
>>>> +		return;
>>>> +	}
>>>> +}
>>>> +
>>>>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>>>  					struct conf_load *conf, int param_idx)
>>>>  {
>>>> @@ -1075,18 +1120,28 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>>>  		if (parm->has_loc &&
>>>>  		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
>>>>  			loc.exprlen != 0) {
>>>> +			int expected_reg = cu->register_params[param_idx];
>>>>  			Dwarf_Op *expr = loc.expr;
>>>>  
>>>>  			switch (expr->atom) {
>>>>  			case DW_OP_reg0 ... DW_OP_reg31:
>>>> +				/* mark parameters that use an unexpected
>>>> +				 * register to hold a parameter; these will
>>>> +				 * be problematic for users of BTF as they
>>>> +				 * violate expectations about register
>>>> +				 * contents.
>>>> +				 */
>>>> +				if (expected_reg >= 0 && expected_reg != expr->atom)
>>>> +					parm->unexpected_reg = 1;
>>>> +				break;
>>>
>>> Overall I guess it's a step forward, since it addresses the immediate issue,
>>> but probably too fragile long term.
>>>
>>> Your earlier example:
>>>  __bpf_kfunc void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
>>>
>>> had
>>> 0x0891dabe:     DW_TAG_formal_parameter
>>>                   DW_AT_location        (indexed (0x7a) loclist = 0x00f50eb1:
>>>                      [0xffffffff82031185, 0xffffffff8203119e): DW_OP_reg5 RDI
>>>                      [0xffffffff8203119e, 0xffffffff820311cc): DW_OP_reg3 RBX
>>>                      [0xffffffff820311cc, 0xffffffff820311d1): DW_OP_reg5 RDI
>>>                      [0xffffffff820311d1, 0xffffffff820311d2): DW_OP_reg3 RBX
>>>                      [0xffffffff820311d2, 0xffffffff820311d8): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>>
>>> 0x0891dad4:     DW_TAG_formal_parameter
>>>                   DW_AT_location        (indexed (0x7b) loclist = 0x00f50eda:
>>>                      [0xffffffff82031185, 0xffffffff820311bc): DW_OP_reg1 RDX
>>>                      [0xffffffff820311bc, 0xffffffff820311c8): DW_OP_reg0 RAX
>>>                      [0xffffffff820311c8, 0xffffffff820311d1): DW_OP_reg1 RDX)
>>>                   DW_AT_name    ("acked")
>>>
>>> Both args will fail above check. If I'm reading above code correctly.
>>> It checks that every reg in DW_AT_location matches ?
>>
>> It checks location info for those that have it; so in this case the location
>> lists specify rdi on entry for the first parameter (sk)
>>
>>
>> 0x068a0f3b:     DW_TAG_formal_parameter
>>                   DW_AT_location        (indexed (0x74) loclist = 0x00a4c5a0:
>>                      [0xffffffff81b87849, 0xffffffff81b87866): DW_OP_reg5 RDI
>>                      [0xffffffff81b87866, 0xffffffff81b87899): DW_OP_reg3 RBX
>>                      [0xffffffff81b87899, 0xffffffff81b878a0): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                   DW_AT_name    ("sk")
>>                   DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
>>                   DW_AT_decl_line       (446)
>>                   DW_AT_type    (0x06886461 "sock *")
>>
>>
>> no location info for the second (ack):
>>
>> 0x068a0f47:     DW_TAG_formal_parameter
>>                   DW_AT_name    ("ack")
>>                   DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
>>                   DW_AT_decl_line       (446)
>>                   DW_AT_type    (0x06886451 "u32")
>>
>> ...so matching it is skipped, and rdx as the first element in the location list
>> for the third parameter (acked):
>>
>> 0x068a0f52:     DW_TAG_formal_parameter
>>                   DW_AT_location        (indexed (0x75) loclist = 0x00a4c5bb:
>>                      [0xffffffff81b87849, 0xffffffff81b87884): DW_OP_reg1 RDX
>>                      [0xffffffff81b87884, 0xffffffff81b87890): DW_OP_reg0 RAX
>>                      [0xffffffff81b87890, 0xffffffff81b87898): DW_OP_reg1 RDX)
>>                   DW_AT_name    ("acked")
>>                   DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
>>                   DW_AT_decl_line       (446)
>>                   DW_AT_type    (0x06886451 "u32")
>>
>>
>> So this would be okay using the register-checking approach.
> 
> I meant in all that it's not clear that first and only first location info is used.
> Is that the behavior of attr_location() ?
>

I did a bit of additional debugging here; you're right, attr_location() does not
work for location lists so they are skipped. It uses dwarf_getlocation(), but
if we use dwarf_getlocations() (added in elfutils 0.157), single locations and 
location lists will be supported, and in the case of location lists, the first
expression is examined. See [1] for the details of the fix.

> 
>>> Or just first ?
>>>
>>>>  			case DW_OP_breg0 ... DW_OP_breg31:
>>>>  				break;
>>>>  			default:
>>>> -				parm->optimized = 1;
>>>> +				parm->unexpected_reg = 1;
>>>>  				break;
>>>>  			}
>>>>  		} else if (has_const_value) {
>>>> -			parm->optimized = 1;
>>>> +			parm->unexpected_reg = 1;
>>>
>>> Is this part too restrictive as well?
>>> Just because one arg is constant it doesn't mean that the calling convention
>>> is not correct for this and other args.
>>>
>>
>> Great catch; this part is wrong; should just be parm->optimized = 1 as it
>> was before.
> 
> Will this fix change the stats you've quoted earlier ?
> 
> "
> With these changes, running pahole on a gcc-built
> vmlinux skips
> 
> - 1164 functions due to multiple inconsistent function
>   prototypes.  Most of these are "."-suffixed optimized
>   fuctions.
> - 331 functions due to unexpected register usage
>

This changes to

- 1084 functions skipped due to inconsistent function prototypes,
  597 of these are not "."-suffixed functions.
- 255 functions skipped due to unexpected register usage, of which
  only 16 are not "."-suffixed functions.

Overall it's 1339 functions, which is slightly less than
the 1495 we skipped before.
 
> For a clang-built kernel, the numbers are
> 
> - 539 functions with inconsistent prototypes are skipped
> - 209 functions with unexpected register usage are skipped
> "
> 
> How does it compare before/after ?
> iirc there were ~2500 functions skipped in vmlinux-gcc and now it's down to 1164+331 ?
> 
For clang we see

- 539 functions skipped due to inconsistent prototypes (unchanged)
- 272 functions skipped due to unexpected register usage

The increase here appears to be a result of supporting location
lists so we can do more checking on which registers parameters use.

For many of the 272 we see %r15 unexpectedly being used for boolean 
parameters. In some cases the __cold attribute is applied to functions
and they end up using atypical registers. And in some cases -
for example ZSTD_execSequenceEnd() - we see a stack-passed
parameter leading to later parameters using unexpected registers.
In other cases we see the fact that a function does not use
a parameter, resulting in unexpected register use for other
parameters  - __ddebug_add_module() is an example of this, where
the second parameter is unused in the code, so the third uses %rsi.
These are I think the cases we'd really like to catch.

I've sent a small series of fixups to address these issues [1].

Testing indicates we see no issues with missing BTF ids, and the
tracing_struct test still passes.

[1] https://lore.kernel.org/bpf/1676994522-1557-1-git-send-email-alan.maguire@oracle.com/
