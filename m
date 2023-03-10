Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636836B4FE2
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 19:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCJSMj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 13:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCJSMh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 13:12:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10580134AC2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 10:12:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF4RXC016565;
        Fri, 10 Mar 2023 18:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F7JnPN7feLCHO3lZUJMgjJ4gqRMl5J6q1A88pb3Wb4M=;
 b=2w8Q9TsjZ6rSKw/tsd5QISQWxQLCD9/BtxXZyZQhpuqVw18FFRax0bjCD3vPQok7ERhs
 ONaNyoEqkT/BxzYRdMH3vF+mB7qgY57+XcS+Sjvg6LI/27Io5e7Y+ZbW09VWVuRHXARt
 WZgnVbYZUeIdMfD1kgfq03Ks4jkhONm2cUjtXkqDxvoh/SUH7u5EC0+TOduB8qdFGc3t
 8EFCYzesGLqud8BxldkETJ7/211wsWoyyGNsRCHT2QFDwnt8cu7hKewYZ0EPayLFuxIZ
 Yayvh+GyX8tUN2jfmMbtlSuSQRTLmI7bdeJONEtzNMPQ7tR1FOovrPDChshfV4R9hbLi bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn9a79s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:12:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHSwE3024932;
        Fri, 10 Mar 2023 18:12:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6frc2kg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:12:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk+E8LMe3oQaQDvwDuUl8OEWG4fU5Tsz2aJlquCDbxbfmLrWK+/w3OalI3dA5V/cli1Vu54lQHgOt8/w14xAOiE3VcDtvMccFZn5hVvBWGhn9Dg3eQnvlEyy9jYwVQnGQ0+nBZ4e+KzOTV55IrlLuDcGad2HMgrPOOpvZbVkco07UNvLAHBhSmFjCk7mIAQkJeMymrx3kCeYwKPpFPaSVqfGECEagUNLxfupEhHR0w0HzBtmcc6S/wtvsarZtobbSrTINaOlbxiHczvw1FwaYjuthNO6GuxnB1hOLl3XnDeC4TpD62fS9Q10c7fK99Rb9JjQ2YLWR71DzKVK+EFmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7JnPN7feLCHO3lZUJMgjJ4gqRMl5J6q1A88pb3Wb4M=;
 b=h3gD8M/YopKiHjORImr8qcmJX0g8JcnppSK6iiW3xJ+hiuF74EEgIoGflbado27+W6Rb7qk1US+RWIxFqkVoi/pVf4vsvHRMeP2LmLSaY0uV+JKnRHX2R+F1wXYA3xdVzRzpYGiabmtt/Efw6Vuip659R+alQ2NOaaA3yHXBa9cZNc+ZaTES3ST0BXANWGISJkxbXsbbaS577XWHZJmRr52FV5KcXA6/l0Q1KzIjLcaqQohZ8TPfha44jGodIAjsS5xbR9BCeuwTCbLcCiC1daaV9b0gov+r+t5UDSuZCdRmVPzk7laxVxhsalT0s0xqFHQmRmayat5as7puRimB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7JnPN7feLCHO3lZUJMgjJ4gqRMl5J6q1A88pb3Wb4M=;
 b=ZCviZdEkPS1zlMbq9iKmSJ1GDS4JEHIHNY/S1BNFCs0pD7QeKZMHZc3o7umpy4/bCcTGta4YDbh6aao8xO3wGqh8IZLoSTnDFBmiVXLvH7zFT7K9L+TycBSpT7s3O+npBNsOw6Nv1woS3Dz0u67IAL9e1rrWP07u700kzICH+LI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4628.namprd10.prod.outlook.com (2603:10b6:303:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 18:12:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2%6]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 18:12:04 +0000
Subject: Re: [RFC dwarves] syscall functions in BTF
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
References: <ZAsBYpsBV0wvkhh0@krava>
 <faf34d4b-d7a3-2573-383b-2bd8db422734@oracle.com> <ZAtIEmbRSjol/XfK@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <1165988c-31e0-ae6a-b805-9880fb1e6ad3@oracle.com>
Date:   Fri, 10 Mar 2023 18:11:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <ZAtIEmbRSjol/XfK@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0057.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: 124d7c94-4606-4ed3-4777-08db2192f38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgDleqgF1VgbbIlQKhoK42MnS8ncDfq/pPTGXho0FP8ivQFhDqjsbtvaWMAvAHDKIRjqyWz79WwNoXxcoyPPHo0MzFeZK/3gffp/Hds6M9cVmMJwAUt928AMKPASYbXBaJEzzM9tLq0/0OlZou229FiEIfgWIeIH4QmeL6RsJbnl1EXR2LAxeurfhdBqNAFgbf4VVFgN404sX8LvWylWBgFC5GoLo6x+NbBcRVl6anifnRYrp6RsM4//pT06h3IwaKqQgvMcQSq6TDFfi0Ajt5tvPXe3qlltEUU8VomMPxG3iGP+20a4jGhar3ZHckoa4XQJS0XvJu7NDp1mzV4xxvlVoM3fUSMy7DpeZ33GwBRiZYs/f3RQa76DMb0Sad42bbMBTOr3CQ47LndyEfghkyfXEml3ZHiH/Blv+ngb/roL5M8JxWoYgAFol/E1vjEmmGiwXL7aUMRcN5lxlxw/ufZt1segRM5ceu+SJVaBT+HNBvqWB8fk1iqY7dC92hAJFG1y1bUjZm0/e4rPrgzVRU79EH9dWuGK2o2WO5mZ2kSyjPC5yT1rKa78qa9Cyviadb7i1yAI8APkW9+xCO+E6Sh+wcEag1nOBjlAvmJh4vOH9BVpcqs2h5rtEEr3b6bU0bwBR3wtR4mfAgSzTrwqmYS3/daFe4MnwdSD+S6WXmqIXNwrVZuAUFY3H8jpzpGy5p+B6MSaAVsmDdq6GZvVExJYsy+Rf1Q9foePZhOsEJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(5660300002)(44832011)(7416002)(36756003)(83380400001)(66946007)(478600001)(6666004)(6512007)(6506007)(6486002)(2616005)(53546011)(186003)(4326008)(6916009)(8676002)(66476007)(8936002)(41300700001)(66556008)(38100700002)(31696002)(86362001)(316002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVwTXRZSXM0amYzU0psRVp3L3l1UEh4Vkx5Y1VoajkxeVpQZTZ3MEUzVzVi?=
 =?utf-8?B?Y05vRXBDRDlyYTdGSWdGOHlwTzd2cDJLN203WXdpYUVnSldMeWsySjlVaHRi?=
 =?utf-8?B?OTc1cC85UE5HcTYxT0pvQ2ozZ2tvSWt3QkhIdmtBdG1ZZmtDc2N6byt5V0hU?=
 =?utf-8?B?NFBrM29rL292a3JZODFsQzZ3L2ptVlN0aC8yd090Z3lhNGtkR0p5S0N1OWZr?=
 =?utf-8?B?aDg0MDd6cG9CMHJ2U1ZsQmcwRlhHVDArTk94c0EybzhaZXhRcUNtS2NBTU03?=
 =?utf-8?B?UTBudXdlajVIbzNhWUVzcUxoUkpITjJDRjd3ZW42RkhqSUxod0ZJMGo4dlE3?=
 =?utf-8?B?U2RvTUx4M3IweGNJZGowY1JSeUZVOFk5UVJWSEgrZFY2WjYveVkvdkNwcjQv?=
 =?utf-8?B?Zkh3cWdhWXA1MStRWElXdEVrOUFrSU9uZ25vZmt2UHRHR1pFVEJIRUF2dFFX?=
 =?utf-8?B?TmVqeHAxSFhDWkFaVXhLdDV1bzd4eGtQSGdNRFBJQlhNUWFkSERrTlV3K25W?=
 =?utf-8?B?OVkxaGNoM25iNkNPeDA4SUtZMGtPbDdFYWtGUm5ub0Q3SklCWWhwVkh2eXA3?=
 =?utf-8?B?T3MyVUhaYjU3Y0VwelUxb3VQa2dBU0srcWVVdHFRMmQzajdIQkhYdWI3OFFP?=
 =?utf-8?B?TkF1SlBWTTk5c01FaTFUNFF0OTNBU3RBSzJ2aTF0MHM5bEYySDhGemhUWllE?=
 =?utf-8?B?ZnU0NGtleStTdnIyeDdwUEVtV0pZbHhRaVVadkxIZUQ5cVN3bXdsR28zMHZF?=
 =?utf-8?B?d3dhUGR1WkxjRkQ3L1JwYUhud09FZUtFZ1hWNHgyZzhuVFdzVk5odWx5dzZU?=
 =?utf-8?B?dUR5Q0NNU0VVL1Y2SXNGY0RTYUZGQnZQd0dvMEJqM0RzemprNjNneUNLalYy?=
 =?utf-8?B?MnRjbUo0REptY2x3MHFHY0lxNkdTNW5pei92bjJ5eDVUZEkyNmxvZ215TjNj?=
 =?utf-8?B?RytEcFYyblIySlJ3S1RncERGM0l2S09IelplSVNNQWt1djQyMWw2UFd6MFlu?=
 =?utf-8?B?Y1Z1TUE3cTVSSExnbjY0Y29ZS0lURHpJUzRPTXFvTmJJYWx2aVVhUFAzeEF0?=
 =?utf-8?B?cmFYNWV6bTNROEw5NVFIZ1NucE5mcHZZYkxhTU8raVlCcTQ2dkxETXBFcUJE?=
 =?utf-8?B?ZHJaWHJLWUJlaUtTdkVhTHBKbjhSK3lUQmhsc3lnQ25BWXVEa1g5WG1meFZF?=
 =?utf-8?B?bExvbnd6OXpXTkJ6WmhoTEo5NkVTNVhZWFp5cEVQUDZWcTZyRkE2dWRiNDFq?=
 =?utf-8?B?ZS9xT2VzZmNDamtNN0V1Z1pnc2xNeFlmci94N3l3cFh1V3p4blRaa2VSRGJ0?=
 =?utf-8?B?WEg4SVMwVFRhVWZsMnRKT0VMR2Z6aTFBUWU5YkRKck5pTS9KZC80ODViOERw?=
 =?utf-8?B?dGV4NHErcjdFeW5DUjdqczcvUFJVdGhLRXh3Ri8yVVp2OHVCcGRIajhGeERL?=
 =?utf-8?B?UFBRV21yUjRIMGlrZWp4cnRZdTA2N2pPOXNacHFoMDZScVp5QXp5UjNoWWFI?=
 =?utf-8?B?VTFoN09PQnErT3A1QVJKV1hWKzI0TllDOGV6eko4N0k5NzcvZnBrMlRZQ2FY?=
 =?utf-8?B?TWM0RjJuRWlldE1uN2JtYkZURUN3Q1lzcXBtZUJKS1hzSXpjNXRFUjBReTNZ?=
 =?utf-8?B?ZEtoNXRWRWpLdkY2RUt4YjFhQ2RVYmU0bFBINmhzcmJHcXQyUzE2T0JFYXVy?=
 =?utf-8?B?TEJzaUFBbmsrZ0tIZ1MrMUhITVdDTEtlb3VhM1NCMGNkeS9JaWJEcHQxSUpx?=
 =?utf-8?B?alh5YlFLYUVkTnE0WWM4TlR4eVgzTjhhbHZSS1owVzZkaUdhUFkvRVJXaEVi?=
 =?utf-8?B?VEZwSERzTXZ6dXRoYVYvMUcxcnRRbUx3MTB1VVVaQnl4Vm1QdW5zOTUvSVM2?=
 =?utf-8?B?dUhRd1ViM3dTQlRmUW92V0QrcXdzV1pIeXB3aXg0NVhTc2xlYjBTaVdxVkxS?=
 =?utf-8?B?VWd1clhYYVJxSTNMTlNZTExTbktSbHc1ZVdsMHFjQVRJTndBbVBTbmpqeTRR?=
 =?utf-8?B?Tk9SUHJDbGErakdiU05YdUpGM3MvMGhmOGc2M0o4Yys4Y0U0N09tQURyeWpJ?=
 =?utf-8?B?em5LNmg5WGtTbzVSdXZOZG9xT092QWtQdjV1aTRtSldvUGtLMWVQVWdZMkZ5?=
 =?utf-8?B?b0lSUTlXdkYwa0pWTUtLSU9PZmhQWldIM211UmJ3RzhlMU9IUmZrdlZtaTVv?=
 =?utf-8?Q?YGM+Lmm6z23YqNC2DI+iy74=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dngrWkIwNXB4ZGFXWWsxSC9oL2c0NjdJd0NXN1VySWpxajdOS0FoeGRmWEdG?=
 =?utf-8?B?Yks4NnlONlc1Um9DRWE3QXlrRnJYRmppQXA4REhsaFlYTm1DOHdOWFBHZi93?=
 =?utf-8?B?KzAvcWZZNkZPbC9FcUtQUkErZEp4MUJzaXMzVTZZVk9nbG9EWk1hKy9NQ2d1?=
 =?utf-8?B?SHhzOWY2L1hLV3pWZEJBd1pPdmoyMmppVFBGRHVEQis5YU81VkY5OHJxbzl6?=
 =?utf-8?B?Q3FCdTMwWWhuTXdhU2o5Y1kweUd2YTh2MTNEb1NHaWhvaU8xZzlGZHRIYzRI?=
 =?utf-8?B?OVdzUTlZVVVQZ2pGc0o3NGxYUTN2bE9XRE1KdDgwRGtmcTRrS3MrTkZ2Njkr?=
 =?utf-8?B?c3pYMmZ3QWRIeHFZbE5SbGFHTEdIcHgydDlPR1paYlNzVVY5SGJPYzZudHFC?=
 =?utf-8?B?ZFpNUTNiTVJlOU5OT0gxZ05uU3dYYkJQcjdvTmRmL2ZCU0VZUUlKUVluNlBw?=
 =?utf-8?B?SURiMCtLMWtaTXBUV05wU3p1RU0zOU8xalZKSFBPQjQzM0E5QmhCbHgyWmtX?=
 =?utf-8?B?YmhTTEw3dFJGWlEzTW95RThGanU1eU5oSnFHRWNDQ2t2S29OWk9Nei83Nk5M?=
 =?utf-8?B?ekI1Y1RCY3lJRUhvVEFQaXNKbXY0Z3RYMDhxSXc5YkRCME1xa3lOU1NjOU1B?=
 =?utf-8?B?WHBGdWhDZVpqclJnOHo0cHpiZXZJbVNYRStvbk5uSVhvcE9uTnQzeHdiOWZR?=
 =?utf-8?B?NjFsdnJ4NnUrYmNJU3BRRllrbWM3UlNRVzhlZ1FBYWdMbENydHoreTM1TTN1?=
 =?utf-8?B?YjlxcUVjUmJ0bkp5U0VkRnRkYUxXVE01Zk1RcHRQVW0yQm9LMWtrL2dGb1hU?=
 =?utf-8?B?N1c5MEZPWWNTZU0xSUpnWWVtRjVPQm5GNUp1YWxxNExBajE0SU91MnVLZ0tL?=
 =?utf-8?B?VFpURnZDUDZjanZCcFdEaXNRVW1SV2FrWmRhQmhjODVtSk5QTVNxYkdETS9M?=
 =?utf-8?B?bVZzUkI4a3I2RXI0RWlOcmcwNVFxWDNsdnRUc3o1MnVrdzBkejhUTGVXOCt6?=
 =?utf-8?B?QkdXd2ZWZzBpOHJBRlFKOWdhUDVhMUJBdzhPSkFmWmozTnBWUDdlb1RaVldD?=
 =?utf-8?B?akFOM2JsRU9RdkhaelEzVTkrNmJ0UVhuaVREMmQ5c29MQWxlT3kxMnZzZzBQ?=
 =?utf-8?B?emJuRW0zMWpocUdxMUc2czE1dUM0UTN1UXRjRWF6OWhQYk4yQ1NKbTdQMDZZ?=
 =?utf-8?B?WFcxaEI5eUp2Y1Q2eUtpdW1NeFovYkZwRUFOQktob2h0ZmdnSTRWdWRvSkJY?=
 =?utf-8?Q?ohfvNF1yBiNOpPW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124d7c94-4606-4ed3-4777-08db2192f38a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:12:03.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3RxgdzZ4qzZqet4l4lV79NptPx/rdOZOTqSSmlr7dA/ZKdCG0dmT/R8kKoKF3jt4UbyK/J/NKgWCesqcLDAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_09,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100145
X-Proofpoint-GUID: TlhXU-4CqcJnuZFxJ5DE3FgONxPGuls6
X-Proofpoint-ORIG-GUID: TlhXU-4CqcJnuZFxJ5DE3FgONxPGuls6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/03/2023 15:09, Jiri Olsa wrote:
> On Fri, Mar 10, 2023 at 12:43:31PM +0000, Alan Maguire wrote:
>> On 10/03/2023 10:07, Jiri Olsa wrote:
>>> hi,
>>> with latest pahole fixes we get rid of some syscall functions (with
>>> __x64_sys_ prefix) and it seems to fall down to 2 cases:
>>>
>>> - weak syscall functions generated in kernel/sys_ni.c prevent these syscalls
>>>   to be generated in BTF. The reason is the __COND_SYSCALL macro uses
>>>   '__unused' for regs argument:
>>>
>>>         #define __COND_SYSCALL(abi, name)                                      \
>>>                __weak long __##abi##_##name(const struct pt_regs *__unused);   \
>>>                __weak long __##abi##_##name(const struct pt_regs *__unused)    \
>>>                {                                                               \
>>>                        return sys_ni_syscall();                                \
>>>                }
>>>
>>>   and having weak function with different argument name will rule out the
>>>   syscall from BTF functions
>>>
>>>   the patch below workarounds this by using the same argument name,
>>>   but I guess the real fix would be to check the whole type not just
>>>   the argument name.. or ignore weak function if there's non weak one
>>>
>>>   I guess there will be more cases like this in kernel
>>>
>>>
>>
>> Thanks for the report Jiri! I'm working on reusing the dwarves_fprintf.c
>> code to use string comparisons of function prototypes (minus parameter names!)
>> instead as a more robust comparison.  Hope to have something working soon..
> 
> great, I saw the patchset, will check
> 
>>  
>>> - we also do not get any syscall with no arguments, because they are
>>>   generated as aliases to __do_<syscall> function:
>>>
>>>         $ nm ./vmlinux | grep _sys_fork
>>>         ffffffff81174890 t __do_sys_fork
>>>         ffffffff81174890 T __ia32_sys_fork
>>>         ffffffff81174880 T __pfx___x64_sys_fork
>>>         ffffffff81174890 T __x64_sys_fork
>>>
>>>   with:
>>>         #define __SYS_STUB0(abi, name)                                          \
>>>                 long __##abi##_##name(const struct pt_regs *regs);              \
>>>                 ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
>>>                 long __##abi##_##name(const struct pt_regs *regs)               \
>>>                         __alias(__do_##name);
>>>
>>>   the problem seems to be that there's no DWARF data for aliased symbol,
>>>   so pahole won't see any __x64_sys_fork record
>>>   I'm not sure how to fix this one
>>>
>>
>> Is this one a new issue, or did you just spot it when looking at the other case?
> 
> I was trying to attach to all syscalls and noticed some where missing,
> it looks like the alias was used in this place for few years
> 

I looked into this one; in the DWARF associated with these functions I see:

<1><756d2>: Abbrev Number: 24 (DW_TAG_subprogram)
    <756d3>   DW_AT_external    : 1
    <756d3>   DW_AT_name        : (indirect string, offset: 0x8552d): __x64_sys_fork
    <756d7>   DW_AT_decl_file   : 7
    <756d8>   DW_AT_decl_line   : 58
    <756d9>   DW_AT_decl_column : 1
    <756da>   DW_AT_prototyped  : 1
    <756da>   DW_AT_type        : <0x73abd>
    <756de>   DW_AT_declaration : 1
    <756de>   DW_AT_sibling     : <0x756e8>
 <2><756e2>: Abbrev Number: 18 (DW_TAG_formal_parameter)
    <756e3>   DW_AT_type        : <0x73d42>

So it's marked as a declaration, and BTF encoding has skipped declarations
for a while now as they don't have parameter names; I checked out v1.24 of 
dwarves and only __do_sys_fork() is encoded in BTF there too.  Looks like 
the last relevant change around the syscall stubs was in 2020:

d2b5de495ee9 ("x86/entry: Refactor SYSCALL_DEFINE0 macros")

Alan
